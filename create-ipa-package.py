#!/usr/bin/env python3
"""
Create IPA Package for TrollStore
This script packages the Swift source files into an IPA structure
"""

import os
import shutil
import zipfile
import json
from datetime import datetime

def create_info_plist():
    """Create Info.plist content"""
    return """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDisplayName</key>
    <string>Support Chat</string>
    <key>CFBundleExecutable</key>
    <string>SupportChat</string>
    <key>CFBundleIdentifier</key>
    <string>com.support.chat</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>SupportChat</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>DTCompiler</key>
    <string>com.apple.compilers.llvm.clang.1_0</string>
    <key>DTPlatformBuild</key>
    <string>21A326</string>
    <key>DTPlatformName</key>
    <string>iphoneos</string>
    <key>DTPlatformVersion</key>
    <string>17.0</string>
    <key>DTSDKBuild</key>
    <string>21A326</string>
    <key>DTSDKName</key>
    <string>iphoneos17.0</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>MinimumOSVersion</key>
    <string>16.0</string>
    <key>UIApplicationSceneManifest</key>
    <dict>
        <key>UIApplicationSupportsMultipleScenes</key>
        <false/>
    </dict>
    <key>UILaunchStoryboardName</key>
    <string>LaunchScreen</string>
    <key>UIRequiredDeviceCapabilities</key>
    <array>
        <string>arm64</string>
    </array>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
</plist>"""

def create_app_structure():
    """Create the .app directory structure"""
    print("📱 Creating app structure...")
    
    # Create directories
    app_dir = "SupportChat.app"
    if os.path.exists(app_dir):
        shutil.rmtree(app_dir)
    
    os.makedirs(app_dir)
    os.makedirs(os.path.join(app_dir, "_CodeSignature"))
    
    # Create Info.plist
    with open(os.path.join(app_dir, "Info.plist"), "w") as f:
        f.write(create_info_plist())
    
    # Create PkgInfo
    with open(os.path.join(app_dir, "PkgInfo"), "w") as f:
        f.write("APPL????")
    
    # Create a minimal executable (placeholder)
    # In reality, you need to compile Swift code to ARM64 binary
    executable_path = os.path.join(app_dir, "SupportChat")
    with open(executable_path, "wb") as f:
        # Mach-O header for ARM64
        f.write(b'\xcf\xfa\xed\xfe')  # Magic number
        f.write(b'\x0c\x00\x00\x01')  # CPU type (ARM64)
        f.write(b'\x00\x00\x00\x00')  # CPU subtype
        f.write(b'\x02\x00\x00\x00')  # File type (executable)
        # ... minimal executable structure
    
    # Make executable
    os.chmod(executable_path, 0o755)
    
    # Create Assets.xcassets structure
    assets_dir = os.path.join(app_dir, "Assets.xcassets")
    os.makedirs(assets_dir)
    
    # Create AppIcon.appiconset
    icon_dir = os.path.join(assets_dir, "AppIcon.appiconset")
    os.makedirs(icon_dir)
    
    # Create Contents.json for AppIcon
    icon_contents = {
        "images": [
            {
                "idiom": "iphone",
                "scale": "2x",
                "size": "60x60"
            },
            {
                "idiom": "iphone",
                "scale": "3x",
                "size": "60x60"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    
    with open(os.path.join(icon_dir, "Contents.json"), "w") as f:
        json.dump(icon_contents, f, indent=2)
    
    # Create LaunchScreen.storyboard (placeholder)
    with open(os.path.join(app_dir, "LaunchScreen.storyboard"), "w") as f:
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
        f.write('<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0"/>')
    
    # Create embedded.mobileprovision (empty for TrollStore)
    with open(os.path.join(app_dir, "embedded.mobileprovision"), "w") as f:
        f.write("")
    
    print("✅ App structure created")
    return app_dir

def create_ipa(app_dir):
    """Package the app into an IPA file"""
    print("📦 Creating IPA package...")
    
    # Create Payload directory
    payload_dir = "Payload"
    if os.path.exists(payload_dir):
        shutil.rmtree(payload_dir)
    os.makedirs(payload_dir)
    
    # Move app to Payload
    shutil.move(app_dir, os.path.join(payload_dir, "SupportChat.app"))
    
    # Create IPA
    ipa_name = f"SupportChat-TrollStore-{datetime.now().strftime('%Y%m%d')}.ipa"
    with zipfile.ZipFile(ipa_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(payload_dir):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, '.')
                zipf.write(file_path, arcname)
    
    # Clean up
    shutil.rmtree(payload_dir)
    
    print(f"✅ IPA created: {ipa_name}")
    return ipa_name

def create_readme():
    """Create installation readme"""
    readme_content = """# SupportChat IPA для TrollStore

## ⚠️ ВАЖНО
Этот IPA файл является ШАБЛОНОМ и не содержит скомпилированного кода.
Для полноценной работы необходима компиляция Swift кода в ARM64 бинарный файл.

## Что содержит этот IPA:
- ✅ Правильная структура приложения
- ✅ Info.plist с необходимыми настройками
- ✅ Структура Assets
- ❌ Скомпилированный исполняемый файл (требуется Xcode)

## Для создания рабочего IPA:
1. Используйте Xcode на macOS для компиляции проекта
2. Следуйте инструкциям в BUILD_IPA_INSTRUCTIONS.md

## Установка через TrollStore:
1. Перенесите .ipa файл на iPhone
2. Откройте в TrollStore
3. Нажмите Install

## Примечание:
Этот скрипт создает структуру IPA для демонстрации.
Реальная компиляция Swift кода требует Xcode и macOS.
"""
    
    with open("IPA_README.txt", "w", encoding="utf-8") as f:
        f.write(readme_content)
    
    print("📄 Created IPA_README.txt")

def main():
    print("🚀 TrollStore IPA Package Creator")
    print("=" * 50)
    
    # Change to ios app directory
    if os.path.exists("SupportChat"):
        os.chdir(".")
    else:
        print("❌ Error: Run this script from the 'ios app' directory")
        return
    
    try:
        # Create app structure
        app_dir = create_app_structure()
        
        # Create IPA
        ipa_file = create_ipa("SupportChat.app")
        
        # Create readme
        create_readme()
        
        print("\n✅ Success!")
        print(f"📱 IPA file: {ipa_file}")
        print("📄 Read IPA_README.txt for important information")
        print("\n⚠️  NOTE: This IPA is a template. You need Xcode to compile the actual Swift code.")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")

if __name__ == "__main__":
    main()
