#!/bin/bash

workspace_id="$(niri msg --json workspaces | jq -r '.[] | select(.name == "󰦑") | .idx')"
if [[ -z $workspace_id ]]; then
  workspace_id="$(niri msg --json workspaces | jq -r '.[].idx' | sort -n | tail -1)"
fi

niri msg action focus-workspace "$workspace_id" && niri msg action set-workspace-name 󰦑

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
