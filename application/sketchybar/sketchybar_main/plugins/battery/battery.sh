#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

DRAWING=on
COLOR=$WHITE
case ${PERCENTAGE} in
9[0-9] | 100)
	ICON=$BATTERY_100
	COLOR=$BATTERY_1
	;;
[6-8][0-9])
	ICON=$BATTERY_75
	COLOR=$BATTERY_2
	;;
[3-5][0-9])
	ICON=$BATTERY_50
	COLOR=$BATTERY_3
	;;
[1-2][0-9])
	ICON=$BATTERY_25
	COLOR=$BATTERY_4
	;;
*)
	ICON=$BATTERY_0
	COLOR=$BATTERY_5
	;;
esac

if [[ $CHARGING != "" ]]; then
	ICON=$BATTERY_CHARGING
fi

sketchybar --set $NAME drawing=$DRAWING icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%" label.font="SF PRO:Semibold:11.0"
