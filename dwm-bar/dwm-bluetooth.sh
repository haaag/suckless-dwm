#!/bin/sh

# Output: [ICON off]
# Output: [ICON on]
# Output: [ICON some-bt-device]

icon_on=""
icon_off=""

bt_status=$(dwm-rofi-bt.sh --status)

dwm_bluetooth_color() {
	green_color="^c#8ec07c^"
	bt_connected="^c#83a598^"
	reset_color="^d^"

	if [ "$bt_status" = "Off" ]; then
		printf "%s%s Off%s" "$icon_off" "$SEP1" "$SEP2"
	elif [ "$bt_status" = "" ]; then
		printf "%s%s%s %sOn%s" "$SEP1" "$green_color" "$icon_on" "$reset_color" "$SEP2"
	else
		printf "%s%s%s %s%s%s" "$SEP1" "$bt_connected" "$icon_on" "$reset_color" "$bt_status" "$SEP2"
	fi
}

dwm_bluetooth() {
	printf "%s" "$SEP1"
	if [ "$bt_status" = "Off" ]; then
		printf "%s %s" "$icon_off" "$bt_status"
	elif [ "$bt_status" = "" ]; then
		printf "%s On" "$icon_on"
	else
		printf "%s %s" "$icon_on" "$bt_status"
	fi
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_bluetooth_color
else
	dwm_bluetooth
fi
