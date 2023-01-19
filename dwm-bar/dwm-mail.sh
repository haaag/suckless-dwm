#!/bin/sh

# dwm_mail
#   

# Output: [icon  3]

icon=""
mailbox=$(find "$HOME"/.local/share/mail/*/INBOX/new -type f | wc -l)

dwm_mail() {
	printf "%s" "$SEP1"
	printf "%s  %s" "$icon" "$mailbox"
	printf "%s\n" "$SEP2"
}

dwm_mail_color() {
	blue_color="^c#458588^"
	reset_color="^d^"

	if [ "$mailbox" -eq 0 ]; then
		printf "%s" "$SEP1"
		printf "%s%s %s %s" "$blue_color" "$icon" "$reset_color" "$mailbox"
		printf "%s\n" "$SEP2"
	else
		printf "%s" "$SEP1"
		printf "%s%s %s %s" "$blue_color" "$icon" "$reset_color" "$mailbox"
		printf "%s\n" "$SEP2"
	fi
}

if [ "$DWM_COLOR" = true ]; then
	dwm_mail_color
else
	dwm_mail
fi
