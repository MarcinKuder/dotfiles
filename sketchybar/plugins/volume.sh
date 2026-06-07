#!/bin/sh

DEVICE="$(SwitchAudioSource -t output -c 2>/dev/null)"
case "$DEVICE" in
  *[Aa]ir[Pp]ods*|*[Ee]arbuds*) DEVICE_ICON="󰦢" ;;
  *[Bb]eats*|*[Hh]eadphone*|*iFi*|*AMR*) DEVICE_ICON="󰋋" ;;
  *[Bb]luetooth*) DEVICE_ICON="󰂯" ;;
  *[Bb]uilt*[Ii]n*|*[Ii]nternal*) DEVICE_ICON="󰓃" ;;
  *[Mm]ac[Bb]ook*) DEVICE_ICON="󰌢" ;;
  *DELL*|*[Hh][Dd][Mm][Ii]*|*[Dd]isplay*) DEVICE_ICON="󰓃" ;;
  *) DEVICE_ICON="󰓃" ;;
esac

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)')"
fi

case "$VOLUME" in
  [6-9][0-9]|100) VOLUME_ICON="󰕾" ;;
  [3-5][0-9]) VOLUME_ICON="󰖀" ;;
  [1-9]|[1-2][0-9]) VOLUME_ICON="󰕿" ;;
  *) VOLUME_ICON="󰖁" ;;
esac

sketchybar --set "$NAME" icon="$DEVICE_ICON" label="$VOLUME_ICON $VOLUME%"
