#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/plugins/icon_map.sh"

SID="$1"
OCCUPIED_COLOR=0xfff0f0f0
EMPTY_COLOR=0xff585858

FOCUSED_SID="${FOCUSED_WORKSPACE:-$FOCUSED}"
if [ -z "$FOCUSED_SID" ]; then
  FOCUSED_SID="$(aerospace list-workspaces --focused)"
fi

if [ "$SID" = "$FOCUSED_SID" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi

apps=$(aerospace list-windows --workspace "$SID" --format "%{app-name}")

icon_strip=""
if [ -n "$apps" ]; then
  while IFS= read -r app; do
    __icon_map "$app"
    icon_strip+="$icon_result "
  done <<< "$apps"
  sketchybar --set "$NAME" \
    label="$icon_strip" \
    icon.color=$OCCUPIED_COLOR
else
  sketchybar --set "$NAME" \
    label="" \
    icon.color=$EMPTY_COLOR
fi
