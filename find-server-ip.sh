#!/bin/bash
# Find local IP address for server configuration

echo "Finding your IP addresses..."
echo "=============================="

# Get all IP addresses
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "macOS detected"
    echo ""
    echo "Wi-Fi IP:"
    ipconfig getifaddr en0 2>/dev/null || echo "Not connected"
    echo ""
    echo "Ethernet IP:"
    ipconfig getifaddr en1 2>/dev/null || echo "Not connected"
else
    # Linux/Other
    echo "Available IPs:"
    hostname -I 2>/dev/null || ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1
fi

echo ""
echo "=============================="
echo "Use one of these IPs in your app configuration"
echo "Make sure your iPhone is on the same network!"
