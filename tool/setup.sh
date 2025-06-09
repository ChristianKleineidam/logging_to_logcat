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
  flutter --version
fi

# Ensure packages are fetched
flutter pub get
( cd example && flutter pub get )

echo "Setup complete."
