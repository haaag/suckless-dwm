#!/bin/sh

# Output: [icon 55°C]

# Icons:     
icon=""

sensors_str=$(sensors |grep temp1 | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
sensors_int=${sensors_str%.*}

dwm_sensors() {
	printf "%s" "$SEP1"
	printf "%s %s°C" "$icon" "$sensors_int"
	printf "%s" "$SEP2"
}

dwm_sensors_color() {
	red_color="^c#fb4934^"
	mid_color="^c#e78a4e^"
	reset_color="^d^"

	printf "%s" "$SEP1"
	if [ "$sensors_int" -gt 70 ] && [ "$sensors_int" -le 79 ]; then
		printf "%s%s%s %s°C" "$mid_color" "$icon" "$reset_color" "$sensors_int"
	elif [ "$sensors_int" -ge 80 ]; then
		printf "%s%s %s°C%s" "$red_color" "$icon" "$sensors_int" "$reset_color"
	else
		printf "%s %s°C" "$icon" "$sensors_int"
	fi
	printf "%s" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_sensors_color
else
	dwm_sensors
fi
