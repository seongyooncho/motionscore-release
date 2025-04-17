#!/bin/bash

set -e

GFILE_ID=$1
if [ -z "$GFILE_ID" ]; then
  echo "Usage: $0 <Google Drive FILE ID>"
  exit 1
fi

# 1. Check and install Homebrew
if ! command -v brew &> /dev/null; then
  echo "[INFO] Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for current and future sessions
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "[INFO] Homebrew is already installed."
fi

# 2. Install dependencies
echo "[INFO] Installing dependencies: qt, opencv, gdown, tmate"
brew install qt opencv gdown tmate

# 3. Download file from Google Drive
echo "[INFO] Downloading MotionScore archive..."
gdown "$GFILE_ID"

# 4. Extract archive to ~
ARCHIVE_NAME=$(ls MotionScore_v*.tar.gz | head -n 1)
if [ -z "$ARCHIVE_NAME" ]; then
  echo "[ERROR] Download failed or unexpected filename."
  exit 1
fi

echo "[INFO] Extracting $ARCHIVE_NAME..."
tar -xvzf "$ARCHIVE_NAME" -C "$HOME"

echo "[DONE] MotionScore installed to $HOME"

