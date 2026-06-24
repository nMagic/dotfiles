#!/bin/bash

current_window="$(niri msg --json focused-window | jq -r '.id')"
workspace_id="$(niri msg --json workspaces | jq -r '.[] | select(.name == "󰦑") | .idx')"
if [[ -z $workspace_id ]]; then
  workspace_id="$(niri msg --json workspaces | jq -r '.[].idx' | sort -n | tail -1)"
fi

niri msg action focus-workspace "$workspace_id" && niri msg action set-workspace-name 󰦑
if [[ "$(cat /etc/hostname)" == "DmitriyPC" ]]; then
  niri msg action move-workspace-to-index 4
fi

snx-rs-gui -m connect &
while [[ $(snxctl status) == "Disconnected" ]]; do
  sleep 0.1
  echo disconnected
done
while [[ $(snxctl status) == "Connecting in progress" ]]; do
  sleep 0.1
  echo connecting
done

while [[ $(snxctl status) == "MFA pending: PasswordInput" ]]; do
  sleep 1
  echo pending
done
if [[ $(snxctl status) == "Disconnected" ]]; then
  echo disconnected
  niri msg action focus-window --id "$current_window"
  niri msg action unset-workspace-name 󰦑
  snx-rs-gui -m exit
  exit 0
fi

remmina -i &
vivaldi &
while [[ "$(niri msg --json focused-window | jq -r '.app_id')" != "vivaldi-stable" ]]; do
  echo "launching vivaldi"
  sleep 0.1
done
yuchat &
while [[ "$(niri msg --json focused-window | jq -r '.app_id')" != "yuchat" ]]; do
  echo "launching yuchat"
  sleep 0.1
done
niri msg action move-column-to-index 1
trueconf &
while [[ "$(niri msg --json focused-window | jq -r '.app_id')" != "TrueConf" ]]; do
  echo "launching trueconf"
  sleep 0.1
done
niri msg action move-column-to-index 2
