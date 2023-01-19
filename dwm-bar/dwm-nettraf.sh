#!/bin/sh

# Output: [ICON_DOWN  1.6MB ICON_UP  24KB]

icon_up=""
icon_down=""

update() {
	sum=0
	for arg; do
		read -r i <"$arg"
		sum=$((sum + i))
	done
	cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
	[ -f "$cache" ] && read -r old <"$cache" || old=0
	printf %d\\n "$sum" >"$cache"
	printf %d\\n $((sum - old))
}

rx=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
tx=$(update /sys/class/net/[ew]*/statistics/tx_bytes)

dwm_nettraf() {
	printf "[%s  %4sB %s %4sB]\\n" "$icon_down" "$(numfmt --to=iec "$rx")" "$icon_up" "$(numfmt --to=iec "$tx")"
}

dwm_nettraf_color() {
	yellow="^c#fabd2f^"
	reset="^d^"
	printf "[%s%s %s %4sB %s%s %s%4sB]\\n" "$yellow" "$icon_down" "$reset" "$(numfmt --to=iec "$rx")" "$yellow" "$icon_up" "$reset" "$(numfmt --to=iec "$tx")"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_nettraf_color
else
	dwm_nettraf
fi
