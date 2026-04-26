#!/bin/bash

snx-rs-gui -m connect &
niri msg action focus-window --id "$(niri msg --json windows | jq -r '.[] | select(.app_id == "snx-rs-gui") | select(.title="VPN Authentication Factor") | .id')"

while [[ $(snxctl status | grep -c "Connected") -eq 0 ]]; do
  sleep 1
done

vivaldi &
sleep 1
yuchat &
sleep 1
trueconf &
remmina -i &
