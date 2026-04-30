#!/bin/bash

snxctl disconnect
killall remmina
killall snx-rs-gui
killall vivaldi-bin
pkill -o yuchat.bin
killall TrueConf

if [[ "$(cat /etc/hostname)" == "DmitriyPC" ]]; then
  niri msg action unset-workspace-name 󰦑
fi
