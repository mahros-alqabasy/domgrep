#!/bin/bash

# Usage: ./bump_version.sh [major|minor|patch]

set -e

if [ -z "$1" ]; then
  echo "Error: Please specify version type: major, minor, or patch."
  exit 1
fi

VERSION_TYPE=$1

# Extract current version from changelog
CURRENT_VERSION=$(head -n1 debian/changelog | awk '{print $2}' | tr -d '()')
echo "Current version: $CURRENT_VERSION"

IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case $VERSION_TYPE in
  major)
    ((MAJOR++))
    MINOR=0
    PATCH=0
    ;;
  minor)
    ((MINOR++))
    PATCH=0
    ;;
  patch)
    ((PATCH++))
    ;;
  *)
    echo "Invalid version type. Use major, minor, or patch."
    exit 1
    ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"
echo "New version: $NEW_VERSION"

# Get current date in RFC 2822 format for changelog
DATE=$(date -R)

# Prepare new changelog entry header
NEW_CHANGELOG_ENTRY="domgrep (${NEW_VERSION}) stable; urgency=medium

  * Automated version bump to ${NEW_VERSION}

 -- Mahros Al-Qabasy <mahros.elqabasy@gmail.com>  ${DATE}
"

# Prepend new changelog entry to debian/changelog
# Use a temp file to avoid in-place issues
TMPFILE=$(mktemp)
echo "${NEW_CHANGELOG_ENTRY}" > "$TMPFILE"
cat debian/changelog >> "$TMPFILE"
mv "$TMPFILE" debian/changelog

# Stage and commit changelog
git add debian/changelog
git commit -m "chore: bump version to ${NEW_VERSION}"

# Create git tag
git tag "v${NEW_VERSION}"

echo "Version bumped, changelog updated, and tag v${NEW_VERSION} created."
echo "Push with: git push origin main --tags"
