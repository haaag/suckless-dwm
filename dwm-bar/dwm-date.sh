#!/bin/sh

# Output: "[ICON Fri DD-MM]"

icon=""

date_var=$(date "+%a %d-%m")

dwm_date_other() {
	# blue_color="^c#83a598^"
	# magenta_color="^c#d3869b^"
	# reset_color="^d^"
	printf "%s" "$SEP1"
	printf "%s %s" "$(date "+%a %d-%m] [ %H:%M")" "$icon"
	printf "%s\n" "$SEP2"
}

dwm_date() {
	printf "%s" "$SEP1"
	printf "%s %s" "$icon" "$date_var"
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_date
else
	dwm_date
fi
