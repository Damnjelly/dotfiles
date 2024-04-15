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
	title: "Run",
	description: "launch app",
	commands: 
	[
		{ 
			name: "list-desktop-files", 
			title: "List applications", 
			mode: "filter"
		},
		{
			name: "run-application",
			mode: "silent",
			hidden: true,
			title: "Run application",
			params: 
			[
				{ 
					name: "applicationname", 
					type: "string", 
					title: "Application"
				}
			] 
		}
	]
}'
exit 0
fi

# check if j4-dmenu-desktop is installed
if ! [ -x "$(command -v j4-dmenu-desktop)" ]; then
	echo "j4-dmenu-desktop is not installed. Please install it." >&2
	exit 1
fi

COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "list-desktop-files" ]; then
	j4-dmenu-desktop --dmenu="cat > /tmp/elements.txt"
	cat /tmp/elements.txt | jq -R '{
	title: .,
	actions: 
	[
		{ 
			title: "Run application", 
			type: "run", 
			command: "run-application",
			params: {applicationname: .},
			exit: true
		}
	]
}' | jq -s '{ items: . }'
elif [ "$COMMAND" = "run-application" ]; then
	APPLICATIONNAME=$(echo "$1" | jq -r '.params.applicationname')
	j4-dmenu-desktop --dmenu="(cat &> /dev/null) | (echo '$APPLICATIONNAME')"
fi
