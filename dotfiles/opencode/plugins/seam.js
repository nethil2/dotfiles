// Seam Code Events Plugin - bridges opencode lifecycle to the Seam surface.
// Managed by Seam.app - do not edit manually.

import { spawn } from "node:child_process"

const script = `${process.env.HOME}/.seam/hooks/seam-opencode-hook.sh`

const fire = (event, tool) => {
  try {
    spawn(script, [event, tool ?? ""], { stdio: "ignore", detached: true }).unref()
  } catch {}
}

// 2.x can run tools inside an `execute` code call; name the inner tool.
const toolName = (tool, input) =>
  tool === "execute" ? (String(input?.code ?? "").match(/tools\.(\w+)/)?.[1] ?? tool) : tool

// opencode 2.x
const setup = async (ctx) => {
  const abort = new AbortController()
  await ctx.tool.hook("execute.before", (e) => fire("tool.execute.before", toolName(e?.tool, e?.input)))
  await ctx.tool.hook("execute.after", (e) => fire("tool.execute.after", toolName(e?.tool, e?.input)))
  ;(async () => {
    for await (const event of ctx.event.subscribe({ signal: abort.signal })) {
      if (event.type === "session.execution.succeeded") fire("session.idle")
      else if (event.type === "session.execution.failed") fire("session.error")
    }
  })().catch(() => {})
  return () => abort.abort()
}

// opencode 1.x
const server = async () => ({
  event: async ({ event }) => {
    if (event.type === "session.idle") fire("session.idle")
    else if (event.type === "session.error") fire("session.error")
  },
  "tool.execute.before": async (input) => fire("tool.execute.before", input?.tool),
  "tool.execute.after": async (input) => fire("tool.execute.after", input?.tool),
})

export default { id: "seam", setup, server }
