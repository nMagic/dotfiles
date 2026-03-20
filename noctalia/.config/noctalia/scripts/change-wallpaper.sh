#!/bin/bash

# echo "$(date) $$" >> $HOME/test

SCHEMES="$HOME/.config/noctalia/scripts/color-schemes.json"

NOCTALIA_HOME="$HOME/.config/noctalia"
NOCTALIA_CONFIG="$NOCTALIA_HOME/settings.json"
NOCTALIA_WALLPAPER_DARK_PATH="$HOME/Pictures/Wallpapers/noctalia_dark.png"
NOCTALIA_WALLPAPER_LIGHT_PATH="$HOME/Pictures/Wallpapers/noctalia_light.png"

if [[ $1 != $NOCTALIA_WALLPAPER_DARK_PATH && $1 != $NOCTALIA_WALLPAPER_LIGHT_PATH ]]; then

    echo $1 > $HOME/.cache/noctalia/wallpaper.original
    rm $NOCTALIA_WALLPAPER_DARK_PATH $NOCTALIA_WALLPAPER_LIGHT_PATH

    SCHEME=$(jq -r '.colorSchemes.predefinedScheme' "$NOCTALIA_CONFIG")
    MODE=$(jq -r '.colorSchemes.darkMode' $NOCTALIA_CONFIG)
    PALLETE=$(jq -r ".\"$SCHEME\".dipc.pallete" "$SCHEMES")
    PALLETE="${PALLETE/#\~/$HOME}"
    STYLE_DARK=$(jq -r ".\"$SCHEME\".dipc.dark" "$SCHEMES")
    STYLE_LIGHT=$(jq -r ".\"$SCHEME\".dipc.light" "$SCHEMES")
    wl-copy "$PALLETE"
    # wl-copy "/home/dmitriy/.cargo/bin/dipc -s \"${STYLE_DARK}\" -o $NOCTALIA_WALLPAPER_DARK_PATH \"$PALLETE\" \"$1\""
    /home/dmitriy/.cargo/bin/dipc -s "$STYLE_DARK" -o $NOCTALIA_WALLPAPER_DARK_PATH "$PALLETE" "$1"
    /home/dmitriy/.cargo/bin/dipc -s "$STYLE_LIGHT" -o $NOCTALIA_WALLPAPER_LIGHT_PATH "$PALLETE" "$1"


    sleep 3
    if [[ "$MODE" == "true" ]]; then
        /usr/bin/qs -c noctalia-shell ipc call wallpaper set $NOCTALIA_WALLPAPER_DARK_PATH all
    else
        /usr/bin/qs -c noctalia-shell ipc call wallpaper set $NOCTALIA_WALLPAPER_LIGHT_PATH all
    fi
fi

/usr/share/sddm/themes/noctalia/sync-shell-wallpaper.sh