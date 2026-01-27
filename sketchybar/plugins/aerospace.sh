#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

set -euo pipefail

TARGET_WORKSPACE="${1:-}"

# Provided by aerospace.toml via `sketchybar --trigger ... FOCUSED_WORKSPACE=...`
FOCUSED="${FOCUSED_WORKSPACE:-}"

# Fallback for initial render / manual runs
if [[ -z "${FOCUSED}" ]]; then
  FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null || true)"
fi

if [[ -n "${TARGET_WORKSPACE}" && "${TARGET_WORKSPACE}" == "${FOCUSED}" ]]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffE4192A \
    label.color=0xffFFFFFF
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    background.color=0x44ffffff \
    label.color=0xffffffff
fi
