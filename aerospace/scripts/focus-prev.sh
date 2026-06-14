#!/usr/bin/env bash
# Focus the previously focused window, wherever it lives — `focus --window-id`
# switches to the window's workspace if it's not the current one.
# Bound to cmd-` ; pairs with track-focus.sh.

STATE="${XDG_CACHE_HOME:-$HOME/.cache}/aerospace"
prev=$(cat "$STATE/prev" 2>/dev/null)
[ -n "$prev" ] && aerospace focus --window-id "$prev"
