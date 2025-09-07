#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set $NAME background.drawing=on
else
  sketchybar --set $NAME background.drawing=off
fi

# GREEN=0xffa6e3a1
# RED=0xfff38ba8
#
# ACTIVE_WORKSPACES=$(aerospace list-windows --all --format %{workspace} | sort -u)
#
# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#   sketchybar --set $NAME background.drawing=on
#   if printf "%s\n" "${ACTIVE_WORKSPACES[@]}" | grep -Fxq -- "$1"; then
#     # If current focused workspace is shown on the sketchybar
#     sketchybar --set $NAME label.color=$RED
#   fi
# fi
#
# if [ "$1" = "$PREV_WORKSPACE" ]; then
#   sketchybar --set $NAME background.drawing=off
#   if ! printf "%s\n" "${ACTIVE_WORKSPACES[@]}" | grep -Fxq -- "$1"; then
#     # If the previous workspace doesn't have any windows
#     sketchybar --set $NAME label.color=$GREEN
#   fi
# fi
