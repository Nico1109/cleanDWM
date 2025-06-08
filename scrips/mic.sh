#!/bin/bash

# UNIFIED THEME: State-based coloring with blue fallbacks
# ON: Bright green (\x07), OFF: Sky blue (\x11), Unknown: Yellow (\x05), N/A: Navy blue (\x10)

# Function to check microphone status using different methods
get_mic_status() {
    # Method 1: Try amixer for capture device
    if command -v amixer &> /dev/null; then
        local capture_status=$(amixer get Capture 2>/dev/null | grep '\[on\]')
        if [[ -n "$capture_status" ]]; then
            echo "on"
            return 0
        elif amixer get Capture 2>/dev/null | grep -q '\[off\]'; then
            echo "off"
            return 0
        fi
    fi
    
    # Method 2: Try pactl for default source
    if command -v pactl &> /dev/null; then
        local source_mute=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null)
        if [[ -n "$source_mute" ]]; then
            if echo "$source_mute" | grep -q "no"; then
                echo "on"
                return 0
            else
                echo "off"
                return 0
            fi
        fi
    fi
    
    # Method 3: Try checking alsa capture devices
    if command -v arecord &> /dev/null; then
        local devices=$(arecord -l 2>/dev/null | grep -c "card")
        if [[ "$devices" -gt 0 ]]; then
            # If we have capture devices but can't determine status, assume on
            echo "unknown"
            return 0
        fi
    fi
    
    echo "unavailable"
}

mic_status=$(get_mic_status)

case "$mic_status" in
    "on")
        echo -e "\x07 🎤 ON \x01"   # Bright green for active mic
        ;;
    "off")
        echo -e "\x11 🎤 OFF \x01"  # Blue for inactive mic
        ;;
    "unknown")
        echo -e "\x05 🎤 ? \x01"    # Yellow for unknown status
        ;;
    "unavailable")
        echo -e "\x10 🎤 N/A \x01"  # Navy blue for unavailable
        ;;
esac