#!/bin/bash
# Usage: add-to-houdini.sh /path/to/file
# Copies a file to public/houdini/, updates files.json, commits, and pushes.

set -e

FILE="$1"
if [ -z "$FILE" ]; then
  echo "Usage: add-to-houdini.sh /path/to/file" >&2
  exit 1
fi

PROJECT_DIR="$HOME/kevintraywick"
HOUDINI_DIR="$PROJECT_DIR/public/houdini"

# Copy the file
cp "$FILE" "$HOUDINI_DIR/"
FILENAME=$(basename "$FILE")

# Update files.json
cd "$PROJECT_DIR"
npm run update-houdini

# Commit and push
git add public/houdini/
git commit -m "feat: add $FILENAME to /houdini"
git push
