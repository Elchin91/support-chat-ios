@echo off
REM Build IPA for TrollStore on Windows
REM This script creates an unsigned IPA file that can be installed via TrollStore

echo ===============================================
echo Building IPA for TrollStore...
echo ===============================================

REM Configuration
set PROJECT_NAME=SupportChat
set SCHEME_NAME=SupportChat
set BUILD_DIR=build
set OUTPUT_DIR=output
set IPA_NAME=SupportChat-TrollStore.ipa

REM Clean previous builds
echo Cleaning previous builds...
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
if exist "%OUTPUT_DIR%" rmdir /s /q "%OUTPUT_DIR%"
mkdir "%OUTPUT_DIR%"

REM Navigate to project directory
cd SupportChat

REM Build the app for iOS Device
echo Building the app...
xcodebuild ^
    -project "%PROJECT_NAME%.xcodeproj" ^
    -scheme "%SCHEME_NAME%" ^
    -configuration Release ^
    -derivedDataPath "%BUILD_DIR%" ^
    -sdk iphoneos ^
    -arch arm64 ^
    CODE_SIGN_IDENTITY="" ^
    CODE_SIGNING_REQUIRED=NO ^
    CODE_SIGNING_ALLOWED=NO ^
    DEVELOPMENT_TEAM="" ^
    -allowProvisioningUpdates ^
    clean build

REM Check if build was successful
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b 1
)

echo Build successful!

REM Find the .app file
echo Looking for .app file...
for /r "%BUILD_DIR%" %%i in (*.app) do (
    if exist "%%i\" (
        set APP_PATH=%%i
        goto :found_app
    )
)

echo Could not find .app file!
pause
exit /b 1

:found_app
echo Found app at: %APP_PATH%

REM Create Payload directory
echo Creating IPA structure...
mkdir "..\%OUTPUT_DIR%\Payload"
xcopy /E /I /Y "%APP_PATH%" "..\%OUTPUT_DIR%\Payload\%PROJECT_NAME%.app\"

REM Create IPA file
echo Creating IPA file...
cd "..\%OUTPUT_DIR%"
powershell -command "Compress-Archive -Path 'Payload' -DestinationPath '%IPA_NAME%.zip' -Force"
move "%IPA_NAME%.zip" "%IPA_NAME%"

REM Clean up
rmdir /s /q Payload

REM Final output
if exist "%IPA_NAME%" (
    echo ===============================================
    echo IPA created successfully!
    echo Location: %CD%\%IPA_NAME%
    echo ===============================================
    echo.
    echo Installation instructions:
    echo 1. Transfer %IPA_NAME% to your iPhone
    echo 2. Open TrollStore
    echo 3. Tap '+' and select the IPA file
    echo 4. Tap 'Install'
    echo.
    echo Note: Make sure your backend server is accessible from your iPhone
    echo - Use your computer's IP address instead of localhost
    echo - Ensure both devices are on the same network
) else (
    echo Failed to create IPA!
)

pause
