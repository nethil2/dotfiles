-- Battery icon and charge track
local icons = require("theme.icons")
local ui = require("ui")

local meter = ui.meter("battery", icons.battery.empty)
meter.track:set({ update_freq = 120 })

local function glyph(pct, on_ac)
    if on_ac then
        return icons.battery.charging
    end
    return icons.battery.levels[math.ceil(pct / 10)] or icons.battery.empty
end

local function update()
    sbar.exec("pmset -g batt", function(out)
        local pct = tonumber(out:match("(%d+)%%"))
        if not pct then
            -- no battery
            meter.icon:set({ drawing = false })
            meter.track:set({ drawing = false })
            return
        end
        meter:set(glyph(pct, out:find("AC Power") ~= nil), pct)
    end)
end

meter.track:subscribe({ "routine", "forced", "power_source_change", "system_woke" }, update)
update()
