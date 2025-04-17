#!/bin/bash

set -e

# Get current username and binary path
USER_NAME=$(whoami)
BINARY_PATH="/Users/$USER_NAME/MotionScore/MotionScore"
SUDOERS_LINE="$USER_NAME ALL=(ALL) NOPASSWD: $BINARY_PATH"

# 1. Check for FILE ID
GFILE_ID=$1
if [ -z "$GFILE_ID" ]; then
  echo "Usage: $0 <Google Drive FILE ID>"
  exit 1
fi

# 2. Install Homebrew if missing
if ! command -v brew &> /dev/null; then
  echo "[INFO] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "[INFO] Homebrew is already installed."
fi

# 3. Install dependencies
echo "[INFO] Installing dependencies..."
brew install qt opencv gdown tmate

# 4. Download from Google Drive
echo "[INFO] Downloading MotionScore archive..."
gdown "$GFILE_ID"

ARCHIVE_NAME=$(ls MotionScore_v*.tar.gz | head -n 1)
if [ -z "$ARCHIVE_NAME" ]; then
  echo "[ERROR] Archive not found. Download failed?"
  exit 1
fi

# 5. Extract to home directory
echo "[INFO] Extracting $ARCHIVE_NAME to $HOME..."
tar -xzf "$ARCHIVE_NAME" -C "$HOME"

# 6. Add sudoers rule if not present
echo "[INFO] Configuring sudoers..."
if ! sudo grep -Fxq "$SUDOERS_LINE" /etc/sudoers; then
  echo "$SUDOERS_LINE" | sudo tee -a /etc/sudoers > /dev/null
  echo "[INFO] Sudoers rule added for $USER_NAME."
else
  echo "[INFO] Sudoers rule already exists."
fi

echo "[DONE] Installation complete. You can now run:"
echo "  sudo $BINARY_PATH"

