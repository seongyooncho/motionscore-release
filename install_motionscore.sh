#!/usr/bin/env bash
set -euo pipefail

# Usage: install_motionscore.sh <GoogleDrive file ID> [output_filename]
if [ $# -lt 1 ]; then
  echo "Usage: $0 <GoogleDrive file ID> [output_filename]"
  exit 1
fi

GFILE_ID="$1"
OUTPUT="${2:-MotionScore.tar.gz}"

# 1) Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2) Install Brew Packages
echo "Installing packages: qt, opencv, gdown, tmate"
brew install qt opencv gdown tmate

# 3) Download from Google Drive
echo "Downloading file from Google Drive (ID: $GFILE_ID) → $HOME/$OUTPUT"
cd "$HOME"
gdown --id "$GFILE_ID" -O "$OUTPUT"

# 4) Extract (Overwrite)
echo "Extracting $OUTPUT to $HOME (overwrite existing files)"
tar -xzf "$OUTPUT" -C "$HOME"

echo "✅ Done."

