#!/bin/sh

# check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
	echo "jq is not installed. Please install it." >&2
	exit 1
fi

if [ $# -eq 0 ]; then
	jq -n '
{
	title: "NixOS Search",
	description: "Search NixOS packages",
	preferences: [
		{
				name: "nix-channel",
				title: "Nix Channel",
				type: "string"
		}
	],
	commands: 
	[
		{ 
			name: "search-packages", 
			title: "🔎 Search Packages", 
			mode: "search"
		}
	]
}'
	exit 0
fi

# check if nix-search is installed
if ! [ -x "$(command -v nix-search)" ]; then
	echo "nix-search is not installed. Please install it." >&2
	exit 1
fi 

CHANNEL=$(echo "$1" | jq -r '.preferences.nix-channel')
if [ "$CHANNEL" = "null" ]; then
	echo "Nix channel not specified (e.g '23.11' or 'unstable'). Please set it in your config." >&2
    exit 1
fi

COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "search-packages" ]; then
	QUERY=$(echo "$1" | jq -r '.query')
    if [ "$QUERY" = "null" ]; then
        jq -n '{
            emptyText: "Type anything to searchhhhh",
        }'
        exit 0
    fi
		nix-search --json --channel "$CHANNEL" --query-string="$QUERY" | jq '.package_attr_name' | jq '{
      title: .,
      actions:
      [
         {
						 title: "Copy package",
						 exit: true,
						 type: "copy",
						 text: .
         }
      ]
}' | jq -s '{ items: . }'

elif [ "$COMMAND" = "run-application" ]; then
	APPLICATIONNAME=$(echo "$1" | jq -r '.params.applicationname')
	(set -m ;j4-dmenu-desktop --dmenu="(cat &> /dev/null) | (echo '$APPLICATIONNAME')" &)
	sleep 0.1
	kill -9 $PPID
fi
