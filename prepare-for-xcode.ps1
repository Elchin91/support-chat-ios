# PowerShell script to prepare iOS project for Xcode build
# This creates a ready-to-compile structure

Write-Host "Preparing iOS Project for Xcode Build" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Check if we're in the right directory
if (-not (Test-Path "SupportChat")) {
    Write-Host "Error: Run this script from the 'ios app' directory" -ForegroundColor Red
    exit 1
}

# Create build configuration
Write-Host "`nCreating build configuration..." -ForegroundColor Yellow

# Create xcconfig file for TrollStore build
$xcconfigContent = @'
// TrollStore Build Configuration
// No code signing required

CODE_SIGN_IDENTITY = 
CODE_SIGNING_REQUIRED = NO
CODE_SIGNING_ALLOWED = NO
DEVELOPMENT_TEAM = 
PROVISIONING_PROFILE_SPECIFIER = 
CODE_SIGN_STYLE = Manual

// Build settings
IPHONEOS_DEPLOYMENT_TARGET = 16.0
SWIFT_VERSION = 5.0
TARGETED_DEVICE_FAMILY = 1,2

// Architectures
ARCHS = arm64
VALID_ARCHS = arm64
ONLY_ACTIVE_ARCH = NO

// Other settings
ENABLE_BITCODE = NO
SUPPORTS_MACCATALYST = NO
'@

$xcconfigPath = "SupportChat\TrollStore.xcconfig"
New-Item -ItemType File -Path $xcconfigPath -Force | Out-Null
Set-Content -Path $xcconfigPath -Value $xcconfigContent
Write-Host "Created $xcconfigPath" -ForegroundColor Green

# Create README for Xcode
$xcodeReadme = @'
# Building for TrollStore in Xcode

## Quick Build Steps:

1. Open SupportChat.xcodeproj in Xcode
2. Select the project in navigator
3. Go to project settings > Info > Configurations
4. Set "TrollStore" as configuration file for Release
5. Select "Any iOS Device (arm64)" as build target
6. Build with Cmd+B

## Manual IPA Creation:

1. After build, right-click on SupportChat.app in Products
2. Select "Show in Finder"
3. Create a folder named "Payload"
4. Copy SupportChat.app into Payload folder
5. Compress Payload folder
6. Rename .zip to .ipa

## Server Configuration:

Before running, update the server address in AppConfig.swift:
- Replace 'localhost' with your computer's IP address
- Make sure port 3000 is accessible
'@

Set-Content -Path "SupportChat\XCODE_BUILD_README.txt" -Value $xcodeReadme
Write-Host "Created Xcode build instructions" -ForegroundColor Green

# Create a script to find computer's IP
$findIPScript = @'
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
'@

Set-Content -Path "find-server-ip.sh" -Value $findIPScript
Write-Host "Created IP finder script" -ForegroundColor Green

# Create archive script for easy transfer
$archiveScript = @'
#!/bin/bash
# Create an archive of the project for transfer to macOS

echo "Creating project archive..."

# Clean unnecessary files
find . -name "*.log" -delete
find . -name ".DS_Store" -delete

# Create archive
tar -czf SupportChat-iOS-Project.tar.gz SupportChat/

echo "Archive created: SupportChat-iOS-Project.tar.gz"
echo "Transfer this file to your Mac and extract with:"
echo "tar -xzf SupportChat-iOS-Project.tar.gz"
'@

Set-Content -Path "create-archive.sh" -Value $archiveScript
Write-Host "Created archive script" -ForegroundColor Green

# Summary
Write-Host "`nProject prepared successfully!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Transfer the 'SupportChat' folder to a Mac with Xcode" -ForegroundColor White
Write-Host "2. Open SupportChat.xcodeproj in Xcode" -ForegroundColor White
Write-Host "3. Follow instructions in XCODE_BUILD_README.txt" -ForegroundColor White
Write-Host "4. Build and create IPA for TrollStore" -ForegroundColor White

Write-Host "`nTips:" -ForegroundColor Yellow
Write-Host "- Use 'create-archive.sh' to create a compressed archive" -ForegroundColor White
Write-Host "- Run 'find-server-ip.sh' on your build machine to find server IP" -ForegroundColor White
Write-Host "- Make sure both devices are on the same network" -ForegroundColor White

# Create a simple build checklist
$checklist = @'

=== BUILD CHECKLIST ===

[ ] Xcode installed (version 15+)
[ ] Project opened in Xcode
[ ] Build configuration set to "TrollStore"
[ ] Target device set to "Any iOS Device (arm64)"
[ ] Server IP updated in AppConfig.swift
[ ] Backend server running and accessible
[ ] iPhone with TrollStore ready

===================
'@

Write-Host $checklist -ForegroundColor Magenta
