#!/usr/bin/env zsh

set -euo pipefail

# Cursor window title format (from your settings.json):
#   ${activeEditorShort}${separator}${activeRepositoryName}${separator}${activeRepositoryBranchName}
# The default VS Code/Cursor ${separator} is typically " — ".

get_cursor_window_title() {
  # NOTE: This uses UI scripting. If this returns empty under SketchyBar,
  # give Accessibility permission to `sketchybar` in System Settings.
  osascript <<'APPLESCRIPT' 2>&1
tell application "System Events"
  if not (exists process "Cursor") then return ""
  tell process "Cursor"
    if (count of windows) is 0 then return ""
    return name of front window
  end tell
end tell
APPLESCRIPT
}

# If triggered by front_app_switched, $INFO is the new front app name.
if [[ "${SENDER:-}" == "front_app_switched" && "${INFO:-}" != "Cursor" ]]; then
  sketchybar --set "$NAME" label.drawing=off
  exit 0
fi

TITLE="$(get_cursor_window_title)"
TITLE="${TITLE//$'\n'/ }"

label_from_title() {
  local t="$1"
  local sep=$' — '
  local repo=""
  local branch=""

  if [[ "$t" == *"$sep"* ]]; then
    local -a parts
    parts=("${(@s/$sep/)t}")
    if (( ${#parts[@]} >= 3 )); then
      repo="${parts[-2]}"
      branch="${parts[-1]}"
    fi
  fi

  # Fallback: if we can't parse, just show the title.
  if [[ -z "$repo" || -z "$branch" || "$repo" == "null" || "$branch" == "null" ]]; then
    echo "$t"
  else
    echo "${repo}  ${branch}"
  fi
}

LABEL="$(label_from_title "$TITLE")"
LABEL="${LABEL#"${LABEL%%[![:space:]]*}"}"
LABEL="${LABEL%"${LABEL##*[![:space:]]}"}"

if [[ -z "$LABEL" ]]; then
  # When UI scripting isn't permitted, osascript often yields no title.
  # Keep the item visible only when Cursor is active (front_app.sh toggles drawing),
  # but show a hint so it's debuggable.
  sketchybar --set "$NAME" label="(enable Accessibility for sketchybar)" label.drawing=on
  exit 0
fi

MAX_LENGTH=50
if (( ${#LABEL} > MAX_LENGTH )); then
  LABEL="${LABEL[1,MAX_LENGTH]}…"
fi

sketchybar --set "$NAME" label="$LABEL" label.drawing=on
