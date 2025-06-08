#!/bin/bash

# UNIFIED THEME: Blue tones for static information
# Color scheme: Navy blue (\x10) for errors/unavailable, Sky blue (\x11) for normal static info

# Get username with fallback options
get_username() {
    # Method 1: whoami command
    local username=$(whoami 2>/dev/null)
    if [[ -n "$username" ]]; then
        echo "$username"
        return 0
    fi

    # Method 2: USER environment variable
    if [[ -n "$USER" ]]; then
        echo "$USER"
        return 0
    fi

    # Method 3: LOGNAME environment variable
    if [[ -n "$LOGNAME" ]]; then
        echo "$LOGNAME"
        return 0
    fi

    # Method 4: id command
    username=$(id -un 2>/dev/null)
    if [[ -n "$username" ]]; then
        echo "$username"
        return 0
    fi

    # Fallback
    echo "unknown"
}

name=$(get_username)
icon="󰚭"

# Blue theme for static info
echo -e "\x11 $icon $name \x01"
