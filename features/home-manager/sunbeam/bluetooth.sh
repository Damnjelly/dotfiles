#!/bin/sh

# check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
	echo "jq is not installed. Please install it." >&2
	exit 1
fi

if [ $# -eq 0 ]; then
	jq -n '
{
	title: "Bluetooth",
	description: "Manage bluetooth devices",
	commands: 
	[
		{ 
			name: "bluetooth", 
			title: "📤 Open Manager", 
			mode: "tty"
		}
	]
}'
	exit 0
fi

# check if bluetuith is installed
if ! [ -x "$(command -v bluetuith)" ]; then
	echo "bluetuith is not installed. Please install it." >&2
	exit 1
fi 

COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "bluetooth" ]; then
	bluetuith
fi
