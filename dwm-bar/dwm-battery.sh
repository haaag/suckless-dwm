#!/bin/sh

# Output: [ICON  98%]
# Output: [ICON  98% status]

icon_empty=""
icon_low=""
icon_mid=""
icon_full=""

# Change `BAT1` to whatever your battery is identified as.
# Typically `BAT0` or `BAT1`
bat_charge=$(cat /sys/class/power_supply/BAT1/capacity)
bat_status=$(cat /sys/class/power_supply/BAT1/status)

dwm_battery() {
	printf "%s" "$SEP1"
	if [ "$bat_charge" -lt "30" ]; then
		printf "%s  %s%%" "$icon_empty" "$bat_charge"
	elif [ "$bat_charge" -lt "50" ]; then
		printf "%s  %s%%" "$icon_low" "$bat_charge"
	elif [ "$bat_charge" -lt "90" ]; then
		printf "%s  %s%%" "$icon_mid" "$bat_charge"
	elif [ "$bat_charge" -gt "91" ]; then
		printf "%s  %s%%" "$icon_full" "$bat_charge"
	fi
	printf "%s\n" "$SEP2"
}

dwm_battery_color() {
	empty_color="^c#cc241d^"
	mid_color="^c#e78a4e^"
	full_color="^c#9ECE6A^"
	reset_color="^d^"

	printf "%s" "$SEP1"
	if [ "$bat_charge" -lt "30" ]; then
		printf "%s%s %s %s%% %s" "$empty_color" "$icon_empty" "$reset_color" "$bat_charge" "$bat_status"
	elif [ "$bat_charge" -lt "50" ]; then
		printf "%s%s %s %s%% %s" "$empty_color" "$icon_low" "$reset_color" "$bat_charge" "$bat_status"
	elif [ "$bat_charge" -lt "90" ]; then
		printf "%s%s %s %s%% %s" "$mid_color" "$icon_mid" "$reset_color" "$bat_charge" "$bat_status"
	elif [ "$bat_charge" -lt "95" ]; then
		printf "%s%s %s %s%%" "$full_color" "$icon_full" "$reset_color" "$bat_charge"
	elif [ "$bat_charge" -gt "95" ]; then
		printf "%s%s %s %s%%" "$full_color" "$icon_full" "$reset_color" "$bat_charge"
	fi
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_battery_color
else
	dwm_battery
fi
