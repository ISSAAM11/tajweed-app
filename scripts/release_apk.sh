#!/bin/bash

clear

flutter build apk --release -t lib/main.dart

# Define the path to the output folder and the new APK directory
OUTPUT_DIR="build/app/outputs/flutter-apk"
APK_DIR="apk"  # Change this to your desired APK directory

# Create the APK directory if it does not exist
mkdir -p "$APK_DIR"

# Define the root directory for moving APKs
ROOT_DIR="$APK_DIR"

# Function to get the project name from pubspec.yaml
get_project_name() {
  # Path to pubspec.yaml
  PUBSPEC_FILE="pubspec.yaml"
  
  # Extract the project name from pubspec.yaml
  if [ -f "$PUBSPEC_FILE" ]; then
    # Use grep and awk to extract the value of the name field
    PROJECT_NAME=$(grep '^name:' "$PUBSPEC_FILE" | awk '{print $2}')
  else
    echo "pubspec.yaml not found in the current directory"
    exit 1
  fi
}

# Function to get the version from pubspec.yaml
get_project_version() {
  # Path to pubspec.yaml
  PUBSPEC_FILE="pubspec.yaml"
  
  # Extract the version from pubspec.yaml
  if [ -f "$PUBSPEC_FILE" ]; then
    # Use grep and awk to extract the value of the version field
    PROJECT_VERSION=$(grep '^version:' "$PUBSPEC_FILE" | awk '{print $2}')
  else
    echo "pubspec.yaml not found in the current directory"
    exit 1
  fi
}

# Get the project name and version
get_project_name
get_project_version

echo "📱 Project: $PROJECT_NAME"
echo "🔢 Version: $PROJECT_VERSION"
echo "🏗️  Building APK..."
echo

# Move APK file to the APK directory and rename it
APK_FILE="$OUTPUT_DIR/app-release.apk"
if [ -f "$APK_FILE" ]; then
  # Define the new APK filename
  NEW_NAME="${PROJECT_NAME}-${PROJECT_VERSION}-universal.apk"
  
  # Move and rename the APK file
  mv "$APK_FILE" "$ROOT_DIR/$NEW_NAME"
  
  # Remove the associated SHA file
  SHA_FILE="${APK_FILE}.sha"
  if [ -f "$SHA_FILE" ]; then
    rm "$SHA_FILE"
  fi
  
  echo "APK moved and renamed to: $ROOT_DIR/$NEW_NAME"
else
  echo "APK file not found at: $APK_FILE"
  exit 1
fi

# Launch scrcpy
echo "Launching scrcpy..."
scrcpy &

# Wait for scrcpy to start
sleep 5

# Install the universal APK
APK_TO_INSTALL="$ROOT_DIR/${PROJECT_NAME}-${PROJECT_VERSION}-universal.apk"
if [ -f "$APK_TO_INSTALL" ]; then
  echo "Installing APK onto the connected Android device: $APK_TO_INSTALL"
  adb install -r "$APK_TO_INSTALL"
  if [ $? -eq 0 ]; then
    echo "APK installed successfully: $APK_TO_INSTALL"
  else
    echo "Failed to install APK: $APK_TO_INSTALL"
  fi
else
  echo "APK not found: $APK_TO_INSTALL"
fi

echo "✅ Universal APK build complete: ${PROJECT_NAME}-${PROJECT_VERSION}-universal.apk"
echo "📂 Location: $APK_DIR/"
