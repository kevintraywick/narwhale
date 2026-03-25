#!/bin/bash
# Usage: add-to-cc.sh /path/to/file
# Copies a file to public/cc/, updates files.json, commits, and pushes.

set -e

FILE="$1"
if [ -z "$FILE" ]; then
  echo "Usage: add-to-cc.sh /path/to/file" >&2
  exit 1
fi

PROJECT_DIR="$HOME/kevintraywick"
CC_DIR="$PROJECT_DIR/public/cc"

# Copy the file
cp "$FILE" "$CC_DIR/"
FILENAME=$(basename "$FILE")

# Update files.json
cd "$PROJECT_DIR"
npm run update-cc

# Commit and push
git add public/cc/
git commit -m "feat: add $FILENAME to /cc"
git push
