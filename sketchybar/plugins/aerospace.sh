#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

OCCUPIED_COLOR=0xfff0f0f0
EMPTY_COLOR=0xff585858

if [ "$1" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi

if [ -n "$(aerospace list-windows --workspace "$1")" ]; then
  sketchybar --set "$NAME" label.color=$OCCUPIED_COLOR
else
  sketchybar --set "$NAME" label.color=$EMPTY_COLOR
fi
