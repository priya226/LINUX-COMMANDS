#!/usr/bin/env bash
set -e

# Simple reusable backup script.
# Usage:
#   ./backup.sh <source_dir> <dest_dir>

SRC="$1"
DEST="$2"

# 1) Validate arguments
if [ -z "$SRC" ] || [ -z "$DEST" ]; then
  echo "Usage: $0 <source_dir> <dest_dir>"
  exit 1
fi

# 2) Ensure source exists and is a directory
if [ ! -d "$SRC" ]; then
  echo "Error: source directory '$SRC' does not exist."
  exit 1
fi

# 3) Create destination directory if it doesn't exist
mkdir -p "$DEST"

# 4) Copy contents of source into destination
cp -r "$SRC"/* "$DEST"/

# 5) Log with timestamp
NOW="$(date '+%Y-%m-%d %H:%M:%S')"
echo "[$NOW] SYNCED THE DATA FROM $SRC TO $DEST"
