#!/bin/bash

# UNIFIED THEME: Rainbow gradient for brightness levels
# Dark (navy) -> Blue -> Green -> Yellow -> Orange -> Red -> White (bright)
# Error states use navy blue (\x10)

# Function to get brightness using different methods
get_brightness() {
    local brightness=""
    
    # Method 1: Try brillo
    if command -v brillo &> /dev/null; then
        brightness=$(brillo 2>/dev/null | cut -d'.' -f1)
        if [[ "$brightness" =~ ^[0-9]+$ ]]; then
            echo "$brightness"
            return 0
        fi
    fi
    
    # Method 2: Try brightnessctl
    if command -v brightnessctl &> /dev/null; then
        local bright_info=$(brightnessctl get 2>/dev/null)
        local max_bright=$(brightnessctl max 2>/dev/null)
        if [[ -n "$bright_info" && -n "$max_bright" && "$max_bright" -gt 0 ]]; then
            brightness=$((bright_info * 100 / max_bright))
            echo "$brightness"
            return 0
        fi
    fi
    
    # Method 3: Try reading from /sys/class/backlight
    local backlight_dir="/sys/class/backlight"
    if [[ -d "$backlight_dir" ]]; then
        local backlight_device=$(ls "$backlight_dir" 2>/dev/null | head -n 1)
        if [[ -n "$backlight_device" ]]; then
            local current=$(cat "$backlight_dir/$backlight_device/brightness" 2>/dev/null)
            local max=$(cat "$backlight_dir/$backlight_device/max_brightness" 2>/dev/null)
            if [[ -n "$current" && -n "$max" && "$max" -gt 0 ]]; then
                brightness=$((current * 100 / max))
                echo "$brightness"
                return 0
            fi
        fi
    fi
    
    # Method 4: Try xrandr (for external displays)
    if command -v xrandr &> /dev/null && [[ -n "$DISPLAY" ]]; then
        local brightness_val=$(xrandr --verbose 2>/dev/null | grep -i brightness | head -n 1 | awk '{print $2}')
        if [[ -n "$brightness_val" ]]; then
            brightness=$(echo "$brightness_val * 100" | bc 2>/dev/null | cut -d'.' -f1)
            if [[ "$brightness" =~ ^[0-9]+$ ]]; then
                echo "$brightness"
                return 0
            fi
        fi
    fi
    
    echo "N/A"
}

# Get brightness value
brightness=$(get_brightness)

# Brightness icons array (0-100% range)
icons=("󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨")

if [[ "$brightness" == "N/A" ]]; then
    echo -e "\x10 󰛩 N/A \x01"  # Navy blue for no data
else
    # Validate brightness is a number
    if [[ "$brightness" =~ ^[0-9]+$ ]]; then
        # Ensure brightness is within bounds
        if [[ "$brightness" -lt 0 ]]; then
            brightness=0
        elif [[ "$brightness" -gt 100 ]]; then
            brightness=100
        fi
        
        # Enhanced brightness display with rainbow gradient (low to high brightness)
        get_brightness_color_and_icon() {
            local bright_level=$1
            
            # Icon selection based on brightness level
            local icon_index=$((bright_level / 10))
            if [[ "$icon_index" -gt 10 ]]; then
                icon_index=10
            fi
            local icon=${icons[$icon_index]}
            
            # Rainbow color gradient from dark to bright (violet->blue->green->yellow->orange->red)
            local color_code
            if [[ "$bright_level" -ge 90 ]]; then
                color_code="\x01"  # White - Maximum brightness
            elif [[ "$bright_level" -ge 80 ]]; then
                color_code="\x0E"  # Crimson - Very bright (red end of spectrum)
            elif [[ "$bright_level" -ge 70 ]]; then
                color_code="\x0D"  # Coral - High brightness (orange-red)
            elif [[ "$bright_level" -ge 60 ]]; then
                color_code="\x0C"  # Light orange - Medium-high brightness
            elif [[ "$bright_level" -ge 50 ]]; then
                color_code="\x0B"  # Amber - Medium brightness (yellow)
            elif [[ "$bright_level" -ge 40 ]]; then
                color_code="\x05"  # Yellow - Medium brightness
            elif [[ "$bright_level" -ge 30 ]]; then
                color_code="\x09"  # Lime green - Medium-low brightness
            elif [[ "$bright_level" -ge 20 ]]; then
                color_code="\x08"  # Green - Low brightness
            elif [[ "$bright_level" -ge 10 ]]; then
                color_code="\x11"  # Sky blue - Very low brightness
            else
                color_code="\x10"  # Navy blue - Minimal brightness (violet end)
            fi
            
            echo "${color_code} ${icon}"
        }
        
        # Get enhanced brightness display
        brightness_display=$(get_brightness_color_and_icon "$brightness")
        echo -e "$brightness_display $brightness% \x01"
    else
        echo -e "\x10 󰛩 Error \x01"  # Navy blue for errors
    fi
fi
