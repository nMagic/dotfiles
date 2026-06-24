#!/bin/bash

snx-rs-gui -m disconnect
while [[ $(snxctl status) != "Disconnected" ]]; do
  sleep 0.1
  echo "snx disconnecting"
done
snx-rs-gui -m exit
while [[ ! $(pgrep -c snx-rs-gui) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting snx gui"
done
killall remmina
while [[ ! $(pgrep -c remmina) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting remmina"
done
killall vivaldi-bin
while [[ ! $(pgrep -c vivaldi-bin) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting vivaldi"
done
killall TrueConf
while [[ ! $(pgrep -c TrueConf) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting trueconf"
done
pkill -o yuchat.bin
while [[ ! $(pgrep -c yuchat) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting yuchat"
done

if [[ "$(cat /etc/hostname)" == "DmitriyPC" ]]; then
  niri msg action unset-workspace-name 󰦑
fi
