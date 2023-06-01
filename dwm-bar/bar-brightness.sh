#!/usr/bin/env bash

declare -A icons
# 
brightness="/sys/class/backlight/amdgpu_bl0/brightness"
bdv=$(cat $brightness)

icons[off]="brightness-off"
icons[low]="brightness-low"
icons[medium]="brightness-medium"
icons[high]="brightness-high"

notification() {
	title="Brightness status"
	body="Brightness value $2"
	icon=${icons["$1"]}
	notifyme.py --icon="$icon" --title="$title" --body="$body"
}

case $1 in
up)
	echo $((bdv + 20)) >$brightness
	cat $brightness
	notification "low" "$bdv"
	;;
down)
	echo $((bdv - 20)) >$brightness
	cat $brightness
	;;
*)
	echo "$bdv"
	;;
esac
