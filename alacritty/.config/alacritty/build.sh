SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cp "$SCRIPTPATH/base.toml" "$SCRIPTPATH/alacritty.toml"
mkdir "$HOME/.config/alacritty" 2>/dev/null
git clone https://github.com/alacritty/alacritty-theme "$HOME/.config/alacritty/themes-from-git"