#!/bin/bash

# Build IPA for TrollStore
# This script creates an unsigned IPA file that can be installed via TrollStore

echo "🚀 Starting IPA build for TrollStore..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="SupportChat"
SCHEME_NAME="SupportChat"
BUILD_DIR="build"
OUTPUT_DIR="output"
IPA_NAME="SupportChat-TrollStore.ipa"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf "$BUILD_DIR"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Navigate to project directory
cd "SupportChat" || exit 1

# Build the app for iOS Device
echo "🔨 Building the app..."
xcodebuild \
    -project "$PROJECT_NAME.xcodeproj" \
    -scheme "$SCHEME_NAME" \
    -configuration Release \
    -derivedDataPath "$BUILD_DIR" \
    -sdk iphoneos \
    -arch arm64 \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO \
    DEVELOPMENT_TEAM="" \
    -allowProvisioningUpdates \
    clean build

# Check if build was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Build successful!${NC}"

# Find the .app file
APP_PATH=$(find "$BUILD_DIR" -name "*.app" -type d | head -n 1)

if [ -z "$APP_PATH" ]; then
    echo -e "${RED}❌ Could not find .app file!${NC}"
    exit 1
fi

echo "📦 Found app at: $APP_PATH"

# Create Payload directory
echo "📁 Creating IPA structure..."
mkdir -p "../$OUTPUT_DIR/Payload"
cp -r "$APP_PATH" "../$OUTPUT_DIR/Payload/"

# Create IPA file
echo "🎁 Creating IPA file..."
cd "../$OUTPUT_DIR" || exit 1
zip -r "$IPA_NAME" Payload

# Clean up
rm -rf Payload

# Final output
if [ -f "$IPA_NAME" ]; then
    echo -e "${GREEN}✅ IPA created successfully!${NC}"
    echo -e "${GREEN}📍 Location: $(pwd)/$IPA_NAME${NC}"
    echo ""
    echo -e "${YELLOW}📱 Installation instructions:${NC}"
    echo "1. Transfer $IPA_NAME to your iPhone"
    echo "2. Open TrollStore"
    echo "3. Tap '+' and select the IPA file"
    echo "4. Tap 'Install'"
    echo ""
    echo -e "${YELLOW}⚠️  Note: Make sure your backend server is accessible from your iPhone${NC}"
    echo "   - Use your computer's IP address instead of localhost"
    echo "   - Ensure both devices are on the same network"
else
    echo -e "${RED}❌ Failed to create IPA!${NC}"
    exit 1
fi
