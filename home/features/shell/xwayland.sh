#!/bin/sh
if [ -z "$1" ]; then
	echo "no parameters given, give <program to run> <column width in px> <window height in px>"
	exit 1
fi
COMMANDS="$1"
echo "$COMMANDS"
niri msg action spawn -- Xwayland
niri msg action spawn -- env DISPLAY=:0 i3 
niri msg action spawn -- env DISPLAY=:0 $COMMANDS


# sleep required else the width is applied to the wrong window
sleep 0.1
if [ -n "$2" ]; then 
	niri msg action set-column-width "$2" 
fi
if [ -n "$3" ]; then
	niri msg action set-window-height "$3"
fi
