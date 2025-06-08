#!/bin/bash

# UNIFIED THEME: Blue tones for static information
# Color scheme: Navy blue (\x10) for errors/unavailable, Sky blue (\x11) for normal static info

# Get the active network interface and its IP address
# Try multiple methods to ensure we get the correct local IP
get_local_ip() {
    # Method 1: Use ip route to find the default route interface and get its IP
    local ip=$(ip route get 8.8.8.8 2>/dev/null | grep -oP 'src \K\S+')
    if [[ -n "$ip" && "$ip" =~ ^(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01]))\. ]]; then
        echo "$ip"
        return 0
    fi
    
    # Method 2: Use nmcli if available
    if command -v nmcli &> /dev/null; then
        ip=$(nmcli -g IP4.ADDRESS device show 2>/dev/null | awk -F/ '{print $1}' | grep -E '^(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01]))\.' | head -n 1)
        if [[ -n "$ip" ]]; then
            echo "$ip"
            return 0
        fi
    fi
    
    # Method 3: Parse ip addr output
    ip=$(ip addr show 2>/dev/null | grep -oP 'inet \K(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01]))\.[^\s/]+' | head -n 1)
    if [[ -n "$ip" ]]; then
        echo "$ip"
        return 0
    fi
    
    # Method 4: Fallback to hostname -I
    ip=$(hostname -I 2>/dev/null | awk '{print $1}')
    if [[ -n "$ip" && "$ip" =~ ^(192\.168|10\.|172\.(1[6-9]|2[0-9]|3[01]))\. ]]; then
        echo "$ip"
        return 0
    fi
    
    echo "N/A"
}

ip=$(get_local_ip)
icon="󰩟"

# Check if we have a valid IP - using blue theme
if [[ "$ip" == "N/A" ]]; then
    echo -e "\x10 $icon No IP \x01"
else
    echo -e "\x11 $icon $ip \x01"
fi
