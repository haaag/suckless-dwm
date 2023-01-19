#!/usr/bin/env bash

# Output: [icon 1.9Gi 25%]

# 
icon=""

# The bash shell arithmetic expression ((...)) can't handle floating point.
[ -z "$(which bc)" ] && exit

dwm_memory() {
	total=$(free --mebi | sed -n '2{p;q}' | awk '{print ($2 / 1024)}')
	used_bytes=$(free --mebi | sed -n '2{p;q}' | awk '{print ($3 / 1024)}')
	percentage=$(echo "$used_bytes*100/$total" | bc)
	used_memory=$(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")

	printf "%s" "$SEP1"
	printf "%s %s %s%%" "$icon" "$used_memory" "$percentage"
	printf "%s\n" "$SEP2"
}

dwm_memory_color() {
	red_color="^c#fb4934^"
	reset_color="^d^"

	total=$(free --mebi | sed -n '2{p;q}' | awk '{print ($2 / 1024)}')
	used_bytes=$(free --mebi | sed -n '2{p;q}' | awk '{print ($3 / 1024)}')
	used_memory=$(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")
	percentage=$(echo "$used_bytes*100/$total" | bc)

	printf "%s" "$SEP1"
	printf "%s%s%s %s%% %s" "$red_color" "$icon" "$reset_color" "$percentage" "$used_memory"
	printf "%s\n" "$SEP2"
}

simple_dwm_memory() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	printf "%s" "$SEP1"
	printf "%s %s" "$icon" "$mem"
	printf "%s\n" "$SEP2"
}

lukes_dwm_memory() {
	printf "%s" "$SEP1"
	free --mebi | sed -n '2{p;q}' | awk '{printf ("%2.2fGiB/%2.2fGiB", ( $3 / 1024), ($2 / 1024))}'
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_memory_color
else
	dwm_memory
fi
