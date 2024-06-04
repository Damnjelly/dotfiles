#!/bin/sh

# check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
	echo "jq is not installed. Please install it." >&2
	exit 1
fi

if [ $# -eq 0 ]; then
	jq -n '
{
	title: "Calculator",
	description: "Calculator",
	commands: 
	[
		{ 
			name: "math", 
			title: "🧮 Math", 
			mode: "search"
		}
	]
}'
	exit 0
fi

COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "math" ]; then
	QUERY=$(echo "$1" | jq -r '.query')
    if [ "$QUERY" = "null" ]; then
        jq -n '{
            emptyText: "Enter a calculation",
        }'
        exit 0
    fi
		awk "BEGIN {print "$QUERY"}" | jq -R '{
		title: .,
		actions:
		[
			 {
					 title: "Copy answer",
					 type: "copy",
					 exit: true,
					 text: .
			 }
		]
}' | jq -s '{ dynamic: true, items: . }'
fi
