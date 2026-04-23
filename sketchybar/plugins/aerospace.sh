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

FOCUSED_BG=0xff393925
UNFOCUSED_BG=0x40393925

if [ "$SID" = "$FOCUSED_SID" ]; then
  sketchybar --set "$NAME" background.color=$FOCUSED_BG
else
  sketchybar --set "$NAME" background.color=$UNFOCUSED_BG
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
    icon.padding_left=8 \
    icon.padding_right=8 \
    label.padding_right=8 \
    icon.color=$OCCUPIED_COLOR
else
  sketchybar --set "$NAME" \
    label="" \
    icon.padding_left=12 \
    icon.padding_right=12 \
    label.padding_right=0 \
    icon.color=$EMPTY_COLOR
fi
