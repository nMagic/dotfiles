#!/bin/bash

vivaldi &
sleep 1
yuchat &
sleep 1
trueconf &
sleep 1
snx-rs-gui -m connect &
remmina -i &
sleep 3
niri msg action focus-window --id $(niri msg --json windows | jq -r '.[] | select(.app_id == "snx-rs-gui") | select(.title="VPN Authentication Factor") | .id')