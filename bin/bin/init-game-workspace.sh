#!/bin/bash

workspace_id="$(niri msg --json workspaces | jq -r '.[] | select(.name == "") | .idx')"
if [[ -z $workspace_id ]]; then
  workspace_id="$(niri msg --json workspaces | jq -r '.[].idx' | sort -n | tail -1)"
fi

niri msg action focus-workspace "$workspace_id" && niri msg action set-workspace-name 
