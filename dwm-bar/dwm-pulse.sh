#!/bin/sh

low_icon=""
mid_icon=""
high_icon=""
muted_icon=""

reset_color="^d^"
red_color="^c#fb4934^"

# Status
current_vol=$(pamixer --get-volume)
muted_vol=$(pulsemixer --get-mute)

dwm_pulse() {
	printf "%s" "$SEP1"
	if [ "$muted_vol" = 1 ] || [ "$current_vol" -eq 0 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-muted-symbolic.svg"
		printf "%s muted" "$muted_icon"
	elif [ "$current_vol" -gt 0 ] && [ "$current_vol" -le 33 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-medium.svg"
		printf "%s %s%%" "$low_icon" "$current_vol"
	elif [ "$current_vol" -gt 33 ] && [ "$current_vol" -le 66 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-medium.svg"
		printf "%s %s%%" "$mid_icon" "$current_vol"
	else
		icon="$HOME/.local/bin/scripts/icons/volume-high.svg"
		printf "%s %s%%" "$high_icon" "$current_vol"
	fi
	dunstify -a "Volume" "Volume" "Volume: " -i "$icon" -h int:value:"$current_vol" -h string:x-canonical-private-synchronous:volume
	printf "%s\n" "$SEP2"
}

dwm_pulse_color() {
	printf "%s" "$SEP1"
	if [ "$muted_vol" = 1 ] || [ "$current_vol" -eq 0 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-muted-symbolic.svg"
		printf "%s%s%s muted" "$red_color" "$muted_icon" "$reset_color"
	elif [ "$current_vol" -gt 0 ] && [ "$current_vol" -le 33 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-medium.svg"
		printf " %s%%" "$current_vol"
	elif [ "$current_vol" -gt 33 ] && [ "$current_vol" -le 66 ]; then
		icon="$HOME/.local/bin/scripts/icons/volume-medium.svg"
		printf " %s%%" "$current_vol"
	else
		icon="$HOME/.local/bin/scripts/icons/volume-high.svg"
		printf " %s%%" "$current_vol"
	fi

	dunstify -a "Volume" "Volume" "Volume: " -i "$icon" -h int:value:"$current_vol" -h string:x-canonical-private-synchronous:volume
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_pulse_color
else
	dwm_pulse
fi
