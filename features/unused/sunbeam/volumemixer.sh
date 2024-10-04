#!/bin/sh

set -eu

# check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
	echo "jq is not installed. Please install it." >&2
	exit 1
fi

if [ $# -eq 0 ]; then
	jq -n '
{
	title: "Mixer",
	description: "Volume mixer",
	commands: 
	[
		{ 
			name: "list-sinks", 
			title: "🔊 Switch output device", 
			mode: "filter"
		},
		{
			name: "switch-sink",
			mode: "silent",
			hidden: true,
			title: "Switch to",
			params: 
			[
				{ 
					name: "sinkname", 
					type: "string", 
					title: "Sink name"
				}
			] 
		},
		{
			name: "device-volume",
			title: "🎵 Change device volume",
			mode: "silent",
			params: 
			[
				{
					name: "Set device volume",
					type: "number",
					title: "Volume in %"
				}
			]
		},
		{
			name: "list-input-sinks",
			title: "🎵 Change application volume",
			mode: "filter"
		},
		{
			name: "application-volume",
			title: "Applications",
			mode: "silent",
			hidden: true,
			params: 
			[
				{
					name: "Set application volume",
					type: "number",
					title: "Volume in %"
				},
				{
					name: "applicationid",
					type: "number",
					title: "application"
				}
			]
		}
	]
}'
	exit 0
fi

# check if pactl is installed
if ! [ -x "$(command -v pactl)" ]; then
	echo "pactl is not installed. Please install it." >&2
	exit 1
fi 

# --- change output device ---
COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "list-sinks" ]; then
	pactl --format=json list sinks | jq '.[] | .volume."front-left".value_percent as $volume | {name, description, $volume}' | jq '{
	title: (.description + ", currently " + .volume),
	actions: 
	[
		{ 
			title: "Switch sink", 
			type: "run", 
			command: "switch-sink",
			params: {sinkname: .name},
		}
	]
}' | jq -s '{ items: . }'

elif [ "$COMMAND" = "switch-sink" ]; then
	SINKNAME=$(echo "$1" | jq -r '.params.sinkname')
	pactl set-default-sink "$SINKNAME"
	kill -9 $PPID

	INPUTS=$(pactl --format=json list sink-inputs | jq -r '.[].properties."object.serial"')
	for INPUT in $INPUTS; do # Move all current inputs to the new default sound card
		pactl move-sink-input "$INPUT" "$SINKNAME"
	done
	kill -9 $PPID

# --- change device volume ---
elif [ "$COMMAND" = "device-volume" ]; then
	VOLUME=$(echo "$1" | jq -r '.params."Set device volume"')
	pactl set-sink-volume @DEFAULT_SINK@ "$VOLUME"%
	kill -9 $PPID

# --- change application volume ---
COMMAND=$(echo "$1" | jq -r '.command')
elif [ "$COMMAND" = "list-input-sinks" ]; then
	pactl --format=json list sink-inputs | jq '.[] | .properties."object.serial" as $id | .properties."media.name" as $name | .volume."front-left".value_percent as $volume | {$id, $name, $volume}' | jq '{
title: (.name + ", currently " + .volume),
	actions: 
	[
		{ 
			title: "Select application", 
			type: "run", 
			command: "application-volume",
			params: {"applicationid": .id}
		}
	]
}' | jq -s '{ items: . }'

elif [ "$COMMAND" = "application-volume" ]; then
	VOLUME=$(echo "$1" | jq -r '.params."Set application volume"')
	APPLICATION=$(echo "$1" | jq -r '.params.applicationid')
	pactl set-sink-input-volume "$APPLICATION" "$VOLUME"%
	kill -9 $PPID
fi
