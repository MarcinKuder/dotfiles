#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

COLOR_OK=0xff7bb58d
COLOR_MID=0xffd4b36a
COLOR_LOW=0xffd98e48
COLOR_CRIT=0xffd66b6b
COLOR_CHARGE=0xff79a8cf

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""; COLOR=$COLOR_OK
  ;;
  [6-8][0-9]) ICON=""; COLOR=$COLOR_OK
  ;;
  [3-5][0-9]) ICON=""; COLOR=$COLOR_MID
  ;;
  [1-2][0-9]) ICON=""; COLOR=$COLOR_LOW
  ;;
  *) ICON=""; COLOR=$COLOR_CRIT
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""; COLOR=$COLOR_CHARGE
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.color="$COLOR" label.color="$COLOR"
