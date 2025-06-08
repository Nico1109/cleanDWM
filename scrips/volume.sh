#!/bin/bash

# UNIFIED THEME: Dynamic volume color progression (gets redder as louder)
# Quiet (0-40%): Bright green -> Green -> Lime green -> Yellow
# Medium (40-70%): Amber -> Light orange  
# Loud (70%+): Coral -> Crimson (dangerous levels)
# Muted: Amber, Error states: Navy blue (\x10)

# Function to get volume using different methods
get_volume_info() {
    local volume=""
    local mute_status=""
    
    # Try amixer first
    if command -v amixer &> /dev/null; then
        volume=$(amixer get Master 2>/dev/null | grep -o -m 1 '[0-9]\+%' | head -n 1)
        mute_status=$(amixer get Master 2>/dev/null | grep '\[on\]' > /dev/null && echo "unmuted" || echo "muted")
    fi
    
    # Try pactl if amixer fails
    if [[ -z "$volume" ]] && command -v pactl &> /dev/null; then
        local sink_info=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null)
        if [[ -n "$sink_info" ]]; then
            volume=$(echo "$sink_info" | grep -o '[0-9]\+%' | head -n 1)
            mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -q "yes" && echo "muted" || echo "unmuted")
        fi
    fi
    
    # Fallback: try alsamixer info
    if [[ -z "$volume" ]] && command -v alsamixer &> /dev/null; then
        volume=$(amixer sget Master 2>/dev/null | grep -o -m 1 '[0-9]\+%' | head -n 1)
        mute_status=$(amixer sget Master 2>/dev/null | grep '\[on\]' > /dev/null && echo "unmuted" || echo "muted")
    fi
    
    echo "$volume|$mute_status"
}

# Get volume information
volume_info=$(get_volume_info)
volume=$(echo "$volume_info" | cut -d'|' -f1)
mute_status=$(echo "$volume_info" | cut -d'|' -f2)

# Check if we got valid volume info
if [[ -z "$volume" ]]; then
    echo -e "\x10 🔊 N/A \x01"  # Navy blue for no data
    exit 0
fi

# Remove % sign for numerical comparison
volume_num=$(echo "$volume" | sed 's/%//')

# Enhanced volume display with progressive red coloring for higher volumes
get_volume_color_and_icon() {
    local vol_num=$1
    local is_muted=$2
    
    # Handle muted state
    if [[ "$is_muted" == "muted" ]]; then
        echo "\x0B 🔇"  # Amber for muted state
        return
    fi
    
    # Progressive color coding - gets redder as volume increases
    local color_code
    local icon
    
    if [[ "$vol_num" -ge 90 ]]; then
        color_code="\x0E"  # Crimson - Very loud, potentially dangerous
        icon="🔊"
    elif [[ "$vol_num" -ge 80 ]]; then
        color_code="\x0D"  # Coral - Loud
        icon="🔊"
    elif [[ "$vol_num" -ge 70 ]]; then
        color_code="\x0C"  # Light orange - High volume
        icon="🔊"
    elif [[ "$vol_num" -ge 60 ]]; then
        color_code="\x0B"  # Amber - Getting loud
        icon="🔉"
    elif [[ "$vol_num" -ge 40 ]]; then
        color_code="\x05"  # Yellow - Medium-high (avoiding \x0A)
        icon="🔉"
    elif [[ "$vol_num" -ge 20 ]]; then
        color_code="\x09"  # Lime green - Medium
        icon="🔉"
    elif [[ "$vol_num" -ge 10 ]]; then
        color_code="\x08"  # Green - Low-medium
        icon="🔈"
    else
        color_code="\x07"  # Bright green - Very low/quiet
        icon="🔈"
    fi
    
    echo "${color_code} ${icon}"
}

# Get enhanced volume display
volume_display=$(get_volume_color_and_icon "$volume_num" "$mute_status")
echo -e "$volume_display $volume \x01"
