#!/bin/bash
# Usage: remove-from-cc.sh filename.pdf
# Removes a file from public/cc/, updates files.json, commits, and pushes.

set -e

FILENAME="$1"
if [ -z "$FILENAME" ]; then
  echo "Usage: remove-from-cc.sh filename.pdf" >&2
  exit 1
fi

PROJECT_DIR="$HOME/kevintraywick"
CC_DIR="$PROJECT_DIR/public/cc"
TARGET="$CC_DIR/$FILENAME"

if [ ! -f "$TARGET" ]; then
  echo "File not found: $TARGET" >&2
  exit 1
fi

rm "$TARGET"

cd "$PROJECT_DIR"
npm run update-cc

git add public/cc/
git commit -m "remove $FILENAME from /cc"
git push
