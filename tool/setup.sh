#!/usr/bin/env bash
set -e

# Install Flutter if not already available
if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y curl unzip xz-utils libglu1-mesa
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz"
  curl -L "$FLUTTER_URL" -o flutter.tar.xz
  tar xf flutter.tar.xz
  export PATH="$PWD/flutter/bin:$PATH"
  git config --global --add safe.directory "$PWD/flutter"
  flutter --version
fi

# Install Android SDK if not already available
if ! command -v sdkmanager >/dev/null 2>&1; then
  echo "Android SDK not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y wget unzip openjdk-17-jdk
  ANDROID_SDK_ROOT="$HOME/android-sdk"
  mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
  cd "$ANDROID_SDK_ROOT"
  CMDLINE_ZIP="commandlinetools-linux-11076708_latest.zip"
  wget -q "https://dl.google.com/android/repository/$CMDLINE_ZIP"
  unzip -q "$CMDLINE_ZIP" -d cmdline-tools
  mv cmdline-tools/cmdline-tools cmdline-tools/latest
  yes | cmdline-tools/latest/bin/sdkmanager --sdk_root="$ANDROID_SDK_ROOT" "platform-tools" "platforms;android-34" "build-tools;34.0.0"
  yes | cmdline-tools/latest/bin/sdkmanager --licenses >/dev/null
  export PATH="$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
  cd -
fi

# Ensure packages are fetched
flutter pub get
( cd example && flutter pub get )

echo "Setup complete."
