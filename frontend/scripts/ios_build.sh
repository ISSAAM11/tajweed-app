#!/bin/bash

# Step 0: Get the directory of the current script
SCRIPT_DIR=$(dirname "$0")

# Step 1: Execute the build_increment.sh script from the same directory
"$SCRIPT_DIR/build_increment.sh"

# Step 2: Update the 'forced' value in the main.dart file
MAIN_DART_PATH="$SCRIPT_DIR/../lib/main.dart"

# Use sed to find and replace the 'forced' value
sed -i '' 's/forced: true/forced: false/g' "$MAIN_DART_PATH"

# Step 3: Proceed with the existing build steps
cd ios
rm -Rf Podfile.lock
pod install --repo-update
cd ..

# Build the ios app
flutter build ios --release

# Create an archive directly using xcodebuild
xcodebuild -workspace ios/Runner.xcworkspace \
           -scheme Runner \
           -configuration Release \
           -sdk iphoneos \
           -archivePath ~/Library/Developer/Xcode/Archives/$(date +%Y-%m-%d)/Runner.xcarchive \
           archive

# Open the Xcode workspace inside the ios folder
open ios/Runner.xcworkspace

# Open Archives folder in Finder
open ~/Library/Developer/Xcode/Archives/$(date +%Y-%m-%d)