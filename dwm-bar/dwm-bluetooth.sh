#!/usr/bin/env bash

# Output: [ICON off]
# Output: [ICON on]
# Output: [ICON some-bt-device]
# Output: [ICON some-bt-device,another-device]

icon_on=""
icon_device_connected=""
icon_off=""

power_on() {
	if bluetoothctl show | grep -q "Powered: yes"; then
		return 0
	else
		return 1
	fi
}

device_connected() {
	device_info=$(bluetoothctl info "$1")
	if echo "$device_info" | grep -q "Connected: yes"; then
		return 0
	else
		return 1
	fi
}

dwm_bt_status() {
	printf "%s" "$SEP1"

	if power_on; then
		mapfile -t paired_devices < <(bluetoothctl devices | grep Device | cut -d ' ' -f 2)

		counter=0

		for device in "${paired_devices[@]}"; do
			if device_connected "$device"; then
				device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)

				if [ $counter -gt 0 ]; then
					printf ",%s" "$device_alias"
				else
					printf "%s %s" "$icon_device_connected" "$device_alias"
				fi
				((counter++))
			fi
		done

		if [ $counter -eq 0 ]; then
			printf "%s On" "$icon_on"
		fi

	else
		printf "%s Off" "$icon_off"
	fi

	printf "%s\n" "$SEP2"
}

if [ "$DWM_COLOR" = true ]; then
	dwm_bt_status
else
	dwm_bt_status
fi
