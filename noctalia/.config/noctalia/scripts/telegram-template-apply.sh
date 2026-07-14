#!/bin/bash

set -euo pipefail

wallpaper="$(noctalia msg wallpaper-get)"

magick "$wallpaper" -blur 0x25 "$XDG_CONFIG_HOME"/telegram-desktop/themes/background.png

zip -j "$XDG_CONFIG_HOME"/telegram-desktop/themes/noctalia.zip \
  "$XDG_CONFIG_HOME"/telegram-desktop/themes/background.png \
  "$XDG_CONFIG_HOME"/telegram-desktop/themes/colors.tdesktop-theme
mv "$XDG_CONFIG_HOME"/telegram-desktop/themes/noctalia.zip "$XDG_CONFIG_HOME"/telegram-desktop/themes/noctalia.tdesktop-theme

rm "$XDG_CONFIG_HOME"/telegram-desktop/themes/background.png
rm "$XDG_CONFIG_HOME"/telegram-desktop/themes/colors.tdesktop-theme
