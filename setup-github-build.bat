@echo off
echo ============================================
echo Setting up GitHub repository for iOS build
echo ============================================

REM Check if git is initialized
if not exist ".git" (
    echo Initializing git repository...
    git init
    git add .
    git commit -m "Initial iOS app commit"
)

REM Create .gitignore if not exists
if not exist ".gitignore" (
    echo Creating .gitignore...
    (
        echo # Xcode
        echo xcuserdata/
        echo *.xcscmblueprint
        echo *.xccheckout
        echo build/
        echo DerivedData/
        echo *.moved-aside
        echo *.pbxuser
        echo !default.pbxuser
        echo *.mode1v3
        echo !default.mode1v3
        echo *.mode2v3
        echo !default.mode2v3
        echo *.perspectivev3
        echo !default.perspectivev3
        echo *.hmap
        echo *.ipa
        echo *.dSYM.zip
        echo *.dSYM
        echo timeline.xctimeline
        echo playground.xcworkspace
        echo .build/
        echo Carthage/Build/
        echo Dependencies/
        echo .accio/
        echo fastlane/report.xml
        echo fastlane/Preview.html
        echo fastlane/screenshots/**/*.png
        echo fastlane/test_output
        echo iOSInjectionProject/
        echo .DS_Store
    ) > .gitignore
    git add .gitignore
    git commit -m "Add .gitignore"
)

echo.
echo Local setup complete!
echo.
echo Next steps to build IPA:
echo 1. Create a new repository on GitHub
echo 2. Add the remote repository:
echo    git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
echo 3. Push the code:
echo    git push -u origin main
echo 4. The GitHub Action will automatically build the IPA
echo 5. Download the IPA from Actions tab - Artifacts
echo.
echo Alternative: Manual trigger
echo You can also manually trigger the build from GitHub Actions tab
echo and specify a custom server IP address
echo.
pause
