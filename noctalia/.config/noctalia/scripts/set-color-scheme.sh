#!/bin/bash

SCHEMES="$HOME/.config/noctalia/scripts/color-schemes.json"
NOCTALIA_HOME="$HOME/.config/noctalia"
NOCTALIA_CONFIG="$NOCTALIA_HOME/settings.json"
NOCTALIA_WALLPAPER_DARK_PATH="$HOME/Pictures/Wallpapers/noctalia_dark.png"
NOCTALIA_WALLPAPER_LIGHT_PATH="$HOME/Pictures/Wallpapers/noctalia_light.png"

PREV_SCHEME=""
PREV_MODE=""
ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"
VSCODE_CONFIG="$HOME/.config/Code - OSS/User/settings.json"
ZELLIJ_CONFIG="$HOME/.config/zellij/config.kdl"

function set_color_scheme {
    local scheme=$1
    local mode=$( [[ "$2" == "true" ]] && echo "dark" || echo "light" )

    if [[ "$(jq -r --arg s "$scheme" '.[$s]' "$SCHEMES")" != "null" ]]; then
        ### ALACRITTY
        local alacritty=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].alacritty.[$m]' "$SCHEMES")

        ### VSCODE
        local vscode=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].vscode.[$m]' "$SCHEMES")

        ###WALLPAPER
        wallpaper=$(cat $HOME/.cache/noctalia/wallpaper.original)

        ###ZELLIJ
        local zellij=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].zellij.[$m]' "$SCHEMES")
    else
        ### ALACRITTY
        local alacritty="themes/noctalia.custom.toml"

        ### VSCODE
        local vscode="NoctaliaTheme"

        ###WALLPAPER
        rm $NOCTALIA_WALLPAPER_DARK_PATH $NOCTALIA_WALLPAPER_LIGHT_PATH
        ln -sf "$(cat $HOME/.cache/noctalia/wallpaper.original)" "$NOCTALIA_WALLPAPER_DARK_PATH"
        ln -sf "$(cat $HOME/.cache/noctalia/wallpaper.original)" "$NOCTALIA_WALLPAPER_LIGHT_PATH"
        local wallpaper=$( [[ "$mode" == "dark" ]] && echo $NOCTALIA_WALLPAPER_LIGHT_PATH || echo  $NOCTALIA_WALLPAPER_DARK_PATH)

        ###ZELLIJ
        zellij="ansi"
    fi

    ### ALACRITTY
    sed --follow-symlinks -i "s,\"~/.config/alacritty/themes.*\",\"~/.config/alacritty/${alacritty}\",g" "$ALACRITTY_CONFIG"

    ### VSCODE
    sed --follow-symlinks -i "s|\"workbench.colorTheme\": \".*\",|\"workbench.colorTheme\": \"${vscode}\",|g" "$VSCODE_CONFIG"

    ### WALLPAPER, GSETTINGS
    if [[ "$scheme" == "$PREV_SCHEME" ]]; then
        if [[ "$mode" == "dark" ]]; then
            notify-send $NOCTALIA_WALLPAPER_DARK_PATH
            /usr/bin/qs -c noctalia-shell ipc call wallpaper set "$NOCTALIA_WALLPAPER_DARK_PATH" all
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        else
            notify-send $NOCTALIA_WALLPAPER_LIGHT_PATH
            /usr/bin/qs -c noctalia-shell ipc call wallpaper set "$NOCTALIA_WALLPAPER_LIGHT_PATH" all
            gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        fi
    else
        /usr/bin/qs -c noctalia-shell ipc call wallpaper set "$wallpaper" all
    fi

    ### ZELLIJ
    sed --follow-symlinks -i "s|theme \".*\"|theme \"${zellij}\"|g" "$ZELLIJ_CONFIG"
}

while true ; do
    SCHEME="$(jq -r '.colorSchemes.predefinedScheme' "$NOCTALIA_CONFIG")"
    MODE="$(jq -r '.colorSchemes.darkMode' $NOCTALIA_CONFIG)"
    if [[ "$SCHEME" != $PREV_SCHEME ]]; then        
        set_color_scheme "$SCHEME" $MODE
        PREV_SCHEME=$SCHEME
    fi

    if [[ "$MODE" != $PREV_MODE ]]; then        
        set_color_scheme "$SCHEME" $MODE
        PREV_MODE=$MODE
    fi

    sleep 1
done