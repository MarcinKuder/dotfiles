#!/usr/bin/env bash
# Switch to the prev/next workspace on the monitor that holds the FOCUSED
# WINDOW — not the monitor under the mouse.
#
# AeroSpace's built-in `workspace next|prev` cycles within its internal
# "focused monitor", which on a multi-monitor setup drifts to wherever the
# mouse last clicked. This anchors the cycle to the focused *window* instead:
# we read the focused workspace (window-based), find which monitor owns it,
# then step within that monitor's workspace list.
#
# Usage: workspace-cycle.sh next|prev

set -euo pipefail

dir="${1:?usage: workspace-cycle.sh next|prev}"

# Workspace of the currently focused window (window-anchored, not mouse).
focused=$(aerospace list-workspaces --focused)

# Find which monitor owns the focused workspace.
mon=""
while IFS= read -r m; do
    if aerospace list-workspaces --monitor "$m" | grep -qx "$focused"; then
        mon="$m"
        break
    fi
done < <(aerospace list-monitors --format '%{monitor-id}')

[ -z "$mon" ] && exit 0

# Ordered workspace list for that monitor.
ws=()
while IFS= read -r w; do
    ws+=("$w")
done < <(aerospace list-workspaces --monitor "$mon")

n=${#ws[@]}
[ "$n" -le 1 ] && exit 0

# Index of the focused workspace within the list.
idx=0
for i in "${!ws[@]}"; do
    if [ "${ws[$i]}" = "$focused" ]; then
        idx="$i"
        break
    fi
done

if [ "$dir" = "next" ]; then
    target="${ws[$(( (idx + 1) % n ))]}"
else
    target="${ws[$(( (idx - 1 + n) % n ))]}"
fi

aerospace workspace "$target"
