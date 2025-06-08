#!/bin/bash

# UNIFIED THEME: Blue tones for static information
# Color scheme: Navy blue (\x10) for errors/unavailable, Sky blue (\x11) for normal static info

# Get current date and time
date=$(date +"%a %d.%m.%y %H:%M" 2>/dev/null)

# Check if date command was successful
if [[ -z "$date" ]]; then
    echo -e "\x04 🕐 Date Error \x01"
    exit 1
fi

# Hour icons array (12-hour format)
hour_icons=("🕛" "🕐" "🕑" "🕒" "🕓" "🕔" "🕕" "🕖" "🕗" "🕘" "🕙" "🕚")

# Get current hour (0-23)
current_hour=$(date +"%H" 2>/dev/null)

# Validate hour and calculate icon index
if [[ "$current_hour" =~ ^[0-9]+$ ]]; then
    icon_index=$((current_hour % 12))
    # Ensure index is within bounds
    if [[ "$icon_index" -lt 0 || "$icon_index" -ge 12 ]]; then
        icon_index=0
    fi
else
    icon_index=0  # Default to 12 o'clock if hour parsing fails
fi

# Output with blue theme for static info
echo -e "\x11 ${hour_icons[$icon_index]} $date \x01"