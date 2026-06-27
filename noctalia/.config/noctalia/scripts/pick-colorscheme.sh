#!/bin/bash
SCHEMES="$HOME/.config/noctalia/scripts/color-schemes.json"

scheme=$(jq -r 'keys[]' $SCHEMES | fuzzel -d --auto-select)
if [[ "$scheme" == "" ]]; then
  exit
fi
source=$(jq -r --arg s "$scheme" '.[$s].source' "$SCHEMES")
noctalia msg color-scheme-set $source $scheme

