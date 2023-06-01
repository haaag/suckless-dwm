#!/bin/sh

# bar icons
low_icon=""
mid_icon=""
high_icon=""
muted_icon=""

# notification icons
icons="$HOME/.scripts/icons/"
noti_low_icon="$icons/volume-low.svg"
noti_medium_icon="$icons/volume-medium.svg"
noti_high_icon="$icons/volume-high.svg"
noti_muted_icon="$icons/volume-muted-symbolic.svg"

# colors
reset_color="^d^"
red_color="^c#fb4934^"

# status
current_vol=$(pamixer --get-volume)
muted_vol=$(pulsemixer --get-mute)

dwm_pulse() {
	printf "%s" "$SEP1"
	if [ "$muted_vol" = 1 ] || [ "$current_vol" -eq 0 ]; then
		icon="$noti_muted_icon"
		printf "%s muted" "$muted_icon"
	elif [ "$current_vol" -gt 0 ] && [ "$current_vol" -le 33 ]; then
		icon="$noti_low_icon"
		printf "%s %s%%" "$low_icon" "$current_vol"
	elif [ "$current_vol" -gt 33 ] && [ "$current_vol" -le 66 ]; then
		icon="$noti_medium_icon"
		printf "%s %s%%" "$mid_icon" "$current_vol"
	else
		icon="$noti_high_icon"
		printf "%s %s%%" "$high_icon" "$current_vol"
	fi
	dunstify -a "Volume" "Volume" "Volume: " -i "$icon" -h int:value:"$current_vol" -h string:x-canonical-private-synchronous:volume
	printf "%s\n" "$SEP2"
}

dwm_pulse_color() {
	printf "%s" "$SEP1"
	if [ "$muted_vol" = 1 ] || [ "$current_vol" -eq 0 ]; then
		icon="$noti_muted_icon"
		printf "%s%s%s muted" "$red_color" "$muted_icon" "$reset_color"
	elif [ "$current_vol" -gt 0 ] && [ "$current_vol" -le 33 ]; then
		icon="$noti_medium_icon"
		printf " %s%%" "$current_vol"
	elif [ "$current_vol" -gt 33 ] && [ "$current_vol" -le 66 ]; then
		icon="$noti_medium_icon"
		printf " %s%%" "$current_vol"
	else
		icon="$noti_high_icon"
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
