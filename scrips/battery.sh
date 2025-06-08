#!/bin/bash

# UNIFIED THEME: Dynamic battery color progression
# High (80%+): Bright green -> Green -> Lime green
# Medium (30-79%): Amber -> Light orange -> Coral  
# Critical (<30%): Crimson -> White (emergency)
# Charging: Green override, Error states: Navy blue (\x10)

# Function to check if battery exists
check_battery() {
    local bat_path="/sys/class/power_supply/BAT0"
    if [[ ! -d "$bat_path" ]]; then
        # Try BAT1 if BAT0 doesn't exist
        bat_path="/sys/class/power_supply/BAT1"
        if [[ ! -d "$bat_path" ]]; then
            return 1
        fi
    fi
    echo "$bat_path"
}

# Check if battery exists
battery_path=$(check_battery)
if [[ -z "$battery_path" ]]; then
    echo -e "\x10 󰚥 No Battery \x01"  # Navy blue for no battery
    exit 0
fi

# Get battery info with error handling
battery_percentage=$(cat "$battery_path/capacity" 2>/dev/null || echo "0")
charging_status=$(cat "$battery_path/status" 2>/dev/null || echo "Unknown")

# Validate battery percentage
if ! [[ "$battery_percentage" =~ ^[0-9]+$ ]] || [ "$battery_percentage" -lt 0 ] || [ "$battery_percentage" -gt 100 ]; then
    battery_percentage=0
fi

# Enhanced battery icons with dynamic color coding
# Color progression: Green (high) -> Yellow-Green -> Amber -> Orange -> Red (critical)
get_battery_color_and_icon() {
    local percentage=$1
    local charging=$2
    
    # Base battery icons
    local base_icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
    local icon_index=$((percentage / 10))
    if [ "$icon_index" -gt 10 ]; then
        icon_index=10
    fi
    local icon=${base_icons[$icon_index]}
    
    # Color selection based on battery level
    local color_code
    if [ "$percentage" -ge 80 ]; then
        color_code="\x07"  # Bright green (high battery)
    elif [ "$percentage" -ge 60 ]; then
        color_code="\x08"  # Green (good battery)
    elif [ "$percentage" -ge 40 ]; then
        color_code="\x09"  # Lime green (medium battery)
    elif [ "$percentage" -ge 30 ]; then
        color_code="\x0B"  # Amber (getting low)
    elif [ "$percentage" -ge 20 ]; then
        color_code="\x0C"  # Light orange (low)
    elif [ "$percentage" -ge 15 ]; then
        color_code="\x0D"  # Coral (very low)
    elif [ "$percentage" -ge 10 ]; then
        color_code="\x0E"  # Crimson (critical)
    else
        color_code="\x01"  # White (emergency - most visible)
    fi
    
    # Override with charging color if charging
    if [ "$charging" = "Charging" ]; then
        if [ "$percentage" -ge 90 ]; then
            color_code="\x07"  # Bright green when nearly full
        else
            color_code="\x08"  # Green when charging
        fi
    fi
    
    echo "${color_code} ${icon}"
}

# Get enhanced battery icon and color
bat_icon=$(get_battery_color_and_icon "$battery_percentage" "$charging_status")

# Critical battery warning
if [ "$battery_percentage" -lt 15 ] && [ "$charging_status" = "Discharging" ]; then
    if command -v notify-send &> /dev/null; then
        notify-send -u critical "Battery Critical" "Battery at $battery_percentage%. Please plug in charger!" -r 999 -t 5000
    fi
fi

# Set status symbol
case "$charging_status" in
    "Charging")
        status_symbol="+"
        ;;
    "Discharging")
        status_symbol="-"
        ;;
    "Full")
        status_symbol="="
        ;;
    "Not charging")
        status_symbol="~"
        ;;
    *)
        status_symbol="?"
        ;;
esac

echo -e "$bat_icon $battery_percentage%$status_symbol \x01"