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
				name: "nixchannel",
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

CHANNEL=$(echo "$1" | jq -r '.preferences.nixchannel')
COMMAND=$(echo "$1" | jq -r '.command')
if [ "$COMMAND" = "search-packages" ]; then
	QUERY=$(echo "$1" | jq -r '.query')
    if [ "$QUERY" = "null" ]; then
        jq -n '{
            emptyText: "Type anything to search",
        }'
        exit 0
    fi
		nix-search --json --channel "$CHANNEL" --query-string="$QUERY" | jq '{package_attr_name, package_position}' | jq --arg CHANNEL "$CHANNEL" '{
      title: .package_attr_name,
      actions:
      [
         {
						 title: "Copy package",
						 type: "copy",
						 exit: true,
						 text: .package_attr_name
         },
         {
						 title: "Open source",
						 type: "open",
						 exit: true,
						 url: "\("https://github.com/NixOS/nixpkgs/blob/nixos-\($CHANNEL)/\(.package_position)"|scan("(^((?!:[0-9]).)*)").[0])"
         }
      ]
}' | jq -s '{ dynamic: true, items: . }'
fi
