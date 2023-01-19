#!/usr/bin/env bash

# xkblayout-state is a small command-line program to get/set the current XKB keyboard layout.
# https://github.com/nonpop/xkblayout-state

# Output: [icon us altgr-intl]

icon=""

check_dependencies=$(which xkblayout-state)
[ -z "$check_dependencies" ] && exit

current_layout() {
	current_layout=$(xkblayout-state print "%s %v")
	printf "%s" "$SEP1"
	printf "%s %s" "$icon" "$current_layout"
	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	current_layout
else
	current_layout
fi
