#!/usr/bin/env bash
# Killswitch: fully remove Cloudflare WARP from this Mac.

set -u

if command -v sudo >/dev/null 2>&1 && [ -x /usr/local/bin/warp-killswitch ]; then
    sudo -n /usr/local/bin/warp-killswitch 2>/dev/null || true
    exit 0
fi

# Fallback if sudoers not in place.
APP="/Applications/Cloudflare WARP.app"
UNINSTALL="${APP}/Contents/Resources/uninstall.sh"

if [ -x "$UNINSTALL" ]; then
    osascript -e "do shell script \"'${UNINSTALL}' -f\" with administrator privileges" >/dev/null 2>&1 || true
fi

if command -v brew >/dev/null 2>&1; then
    rm -rf "$(brew --caskroom)/cloudflare-warp" 2>/dev/null || true
fi

exit 0
