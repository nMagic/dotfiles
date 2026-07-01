#!/bin/bash

if [[ $(snxctl status) != "Disconnected" ]]; then
  snx-rs-gui -m disconnect
  while [[ $(snxctl status) != "Disconnected" ]]; do
    sleep 0.1
    echo "snx disconnecting"
  done
fi
if [[ ! $(pgrep -c snx-rs-gui) -eq 0 ]]; then
  snx-rs-gui -m exit
  while [[ ! $(pgrep -c snx-rs-gui) -eq 0 ]]; do
    sleep 0.1
    echo "Exiting snx gui"
  done
fi
killall remmina
while [[ ! $(pgrep -c remmina) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting remmina"
done
niri msg --json windows |
  jq -r '.[] | select(.app_id == "firefox-work") | .id' |
  xargs niri msg action close-window --id
while [[ ! $(pgrep -c vivaldi-bin) -eq 0 ]]; do
  sleep 0.1
  echo "Exiting vivaldi"
done
while [[ ! $(pgrep -c evolution) -eq 0 ]]; do
  killall -r "evolution.*"
  sleep 0.1
  echo "Exiting evolution"
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

niri msg action unset-workspace-name 󰦑
niri msg action unset-workspace-name 󰈙
