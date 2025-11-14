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
