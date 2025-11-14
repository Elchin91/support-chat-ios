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
