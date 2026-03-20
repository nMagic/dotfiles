#!/bin/bash

CONFIG="$HOME/.config/wlr-which-key/config.yaml"
THEME="$HOME/.config/wlr-which-key/theme.yaml"

sed -E -i --follow-symlinks '/^(background:|color:|border:)/d' "$CONFIG"
cat $THEME <(echo) $CONFIG > $CONFIG'.tmp' && cat $CONFIG'.tmp' > $CONFIG && rm $CONFIG'.tmp' 