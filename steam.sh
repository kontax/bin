#!/bin/bash
X &
# WINE binary
CDLOADER_WINE="wine"
#directory for Steam here
STEAM="$HOME/.wine/drive_c/Program Files/Steam"
cd "$STEAM"
$CDLOADER_WINE "Steam.exe" -- "$@"
