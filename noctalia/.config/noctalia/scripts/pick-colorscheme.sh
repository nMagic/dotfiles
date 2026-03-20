#!/bin/bash
SCHEMES="$HOME/.config/noctalia/scripts/color-schemes.json"

scheme=$(jq -r 'keys[]' $SCHEMES | fuzzel -d --auto-select)
qs -c noctalia-shell ipc call colorScheme set "$scheme"