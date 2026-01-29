#!/usr/bin/env zsh

# Ensure Homebrew path is in PATH
export PATH="/opt/homebrew/bin:$PATH"

# Check if media-control is available
if ! command -v media-control &> /dev/null; then
    sketchybar --set $NAME label.drawing=no icon.color=0xffeed49f
    exit 0
fi

# Get media info as JSON
MEDIA_JSON=$(media-control get 2>/dev/null)

if [ -z "$MEDIA_JSON" ]; then
    sketchybar --set $NAME label.drawing=no icon.color=0xffeed49f
    exit 0
fi

# Parse JSON using jq
PLAYING=$(echo "$MEDIA_JSON" | jq -r '.playing // false')
PLAYBACK_RATE=$(echo "$MEDIA_JSON" | jq -r '.playbackRate // 0')

if [ "$PLAYING" = "true" ] || [ "$PLAYBACK_RATE" = "1" ]; then
    # Playing
    TRACK=$(echo "$MEDIA_JSON" | jq -r '.title // ""')
    ARTIST=$(echo "$MEDIA_JSON" | jq -r '.artist // ""')
    APP_ID=$(echo "$MEDIA_JSON" | jq -r '.bundleIdentifier // ""')
    
    # Icon based on app bundle identifier
    ICON="󰝚"
    case "$APP_ID" in
        *spotify*|*Spotify*) ICON="" ;;
        *Music*|*music*) ICON="󰎆" ;;
        *youtube*|*YouTube*) ICON="󰝚" ;;
        *chrome*|*Chrome*|*safari*|*Safari*|*brave*|*Brave*|*arc*|*Arc*|*Browser*) ICON="󰖟" ;;
    esac

    LABEL=""
    if [ -n "$TRACK" ] && [ "$TRACK" != "null" ]; then
        LABEL="$TRACK"
    fi
    
    if [ -n "$ARTIST" ] && [ "$ARTIST" != "null" ] && [ -n "$LABEL" ]; then
        LABEL="$LABEL  $ARTIST"
    fi
    
    # If still no label, just show the icon
    if [ -z "$LABEL" ]; then
        sketchybar --set $NAME label.drawing=no icon="$ICON" icon.color=0xffa6da95
        exit 0
    fi

    # Truncate label if too long
    MAX_LENGTH=35
    if [ ${#LABEL} -gt $MAX_LENGTH ]; then
        LABEL="${LABEL:0:$MAX_LENGTH}..."
    fi

    sketchybar --set $NAME label="$LABEL" label.drawing=yes icon="$ICON" icon.color=0xffa6da95
else
    # Paused or stopped
    sketchybar --set $NAME label.drawing=no icon.color=0xffeed49f
fi
