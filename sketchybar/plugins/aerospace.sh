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

# Determine if this item should be highlighted
SHOULD_HIGHLIGHT=false

case "${TARGET_WORKSPACE}" in
  "1"|"2"|"3"|"4"|"5")
    # Direct match for workspaces 1-5
    if [[ "${TARGET_WORKSPACE}" == "${FOCUSED}" ]]; then
      SHOULD_HIGHLIGHT=true
    fi
    ;;
esac

if [[ "${SHOULD_HIGHLIGHT}" == "true" ]]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffE4192A \
    label.color=0xffFFFFFF
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    label.color=0xfff5cad3
fi
