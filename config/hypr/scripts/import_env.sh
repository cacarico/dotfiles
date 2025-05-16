#!/usr/bin/env bash

envs=(
  HYPRLAND_INSTANCE_SIGNATURE
)

for v in "${_envs[@]}"; do
  if [[ -n ${!v} ]]; then
    tmux setenv -g "$v" "${!v}"
  fi
done
