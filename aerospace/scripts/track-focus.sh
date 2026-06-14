#!/usr/bin/env bash
# Records AeroSpace focus history so we can jump back to the previously
# focused window (across workspaces). Wired to `on-focus-changed`.
#
# State:
#   $STATE/cur  – window-id currently focused (as last recorded)
#   $STATE/prev – window-id focused just before `cur` (the jump-back target)

STATE="${XDG_CACHE_HOME:-$HOME/.cache}/aerospace"
mkdir -p "$STATE"

new=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)
[ -z "$new" ] && exit 0

cur=$(cat "$STATE/cur" 2>/dev/null)
if [ "$new" != "$cur" ]; then
    [ -n "$cur" ] && printf '%s\n' "$cur" > "$STATE/prev"
    printf '%s\n' "$new" > "$STATE/cur"
fi
