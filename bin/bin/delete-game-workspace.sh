#!/bin/bash

if [[ "$(cat /etc/hostname)" == "DmitriyPC" ]]; then
  niri msg action unset-workspace-name 
fi
