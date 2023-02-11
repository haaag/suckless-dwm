#!/bin/sh

key="$OPEN_WEATHERMAP_KEY"
city="$OPEN_WEATHERMAP_CITY"
units="metric"
api="https://api.openweathermap.org/data/2.5"

get_icon() {
	case $1 in
	01d) icon="" ;;
	01n) icon="" ;;
	02d) icon="" ;;
	02n) icon="" ;;
	03*) icon="" ;;
	04*) icon="" ;;
	09d) icon="" ;;
	09n) icon="" ;;
	10d) icon="" ;;
	10n) icon="" ;;
	11d) icon="" ;;
	11n) icon="" ;;
	13d) icon="" ;;
	13n) icon="" ;;
	50d) icon="" ;;
	50n) icon="" ;;
	*) icon="" ;;
	esac

	echo "$icon "
}

get_weather() {
	if [ -n "$city" ]; then
		if [ "$city" -eq "$city" ] 2>/dev/null; then
			city_param="id=$city"
		else
			city_param="q=$city"
		fi

		weather=$(curl -sf "$api/weather?appid=$key&$city_param&units=$units")
		weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
	else
		location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)
		if [ -n "$location" ]; then
			location_lat="$(echo "$location" | jq '.location.lat')"
			location_lon="$(echo "$location" | jq '.location.lng')"
			weather=$(curl -sf "$api/weather?appid=$key&lat=$location_lat&lon=$location_lon&units=$units")
			weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
			echo -e "$api/weather?appid=$key&lat=$location_lat&lon=$location_lon&units=$units"
		fi
	fi
}

send_notification() {
	curl -sd "$@" ntfy.sh/"$VOID_TOPIC" -o /dev/null
}

dwm_weather() {
	get_weather
	icon=$(get_icon "$weather_icon")
	desc=$(echo "$weather" | jq -r ".weather[0].description")
	temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
	humidity=$(echo "$weather" | jq ".main.humidity" | cut -d "." -f 1)
	message="$desc $temp°C $humidity%"

	printf "%s" "$SEP1"
	printf "%s" "$icon" "$message"
	printf "%s\n" "$SEP2"

	# send_notification "$message"
}

dwm_weather
