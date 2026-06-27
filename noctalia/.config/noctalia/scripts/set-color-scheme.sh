#!/bin/bash

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"
ZELLIJ_CONFIG="$HOME/.config/zellij/config.kdl"
NVIM_COLORSCHEME="$HOME/.config/nvim/lua/plugins/colorscheme.lua"
SCHEMES="$HOME/.config/noctalia/scripts/color-schemes.json"

function set_color_scheme {
  local scheme=$1
  local mode=$2

  if [[ "$(jq -r --arg s "$scheme" '.[$s]' "$SCHEMES")" != "null" ]]; then
    ### ALACRITTY
    local alacritty=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].alacritty.[$m]' "$SCHEMES")
    ### ZELLIJ
    local zellij=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].zellij.[$m]' "$SCHEMES")
    ### NVIM
    local nvim=$(jq -r --arg s "$scheme" --arg m "$mode" '.[$s].nvim.[$m]' "$SCHEMES")
  else
    ### ALACRITTY
    local alacritty="themes/noctalia.custom.toml"
    ### ZELLIJ
    local zellij="matugen"
    ### NVIM
    local nvim="matugen"
  fi

  ### ALACRITTY
  sed --follow-symlinks -i "s,\"~/.config/alacritty/themes.*\",\"~/.config/alacritty/${alacritty}\",g" "$ALACRITTY_CONFIG"
  ### ZELLIJ
  sed --follow-symlinks -i "s|theme \".*\"|theme \"${zellij}\"|g" "$ZELLIJ_CONFIG"
  ### NVIM
  if [[ $nvim == "matugen" ]]; then
    echo false
  else
    sed --follow-symlinks -i "s|colorscheme = \".*\",|colorscheme = \"${nvim}\",|g" "$NVIM_COLORSCHEME"
    for sock in $(ls /run/user/$(id -u) | grep -i "nvim\..*"); do
      nvim --server /run/user/$(id -u)/$sock --remote-send "<Cmd>colorscheme $nvim<CR>"
    done
  fi

  noctalia msg greeter-sync
}

SCHEME="$(noctalia msg color-scheme-get | awk '{ print $2 }')"
MODE="$(noctalia msg theme-mode-get)"
set_color_scheme $SCHEME $MODE
