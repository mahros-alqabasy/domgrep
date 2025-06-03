#!/bin/bash

set -e

VERSION_FILE="VERSION"
CHANGELOG_FILE="debian/changelog"
MAINTAINER_NAME="Mahros Alqabasy"
MAINTAINER_EMAIL="your-email@example.com"
DISTRO="unstable"
URGENCY="medium"

function usage() {
  echo "Usage: $0 [major|minor|patch]"
  exit 1
}

if [ ! -f "$VERSION_FILE" ]; then
  echo "0.0.0" > "$VERSION_FILE"
fi

CURRENT_VERSION=$(cat "$VERSION_FILE")
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case "$1" in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    usage
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "$NEW_VERSION" > "$VERSION_FILE"

echo "Bumped version to $NEW_VERSION"

# Append to changelog in Debian format
CURRENT_DATE=$(date -R)
{
  echo "domgrep ($NEW_VERSION) $DISTRO; urgency=$URGENCY"
  echo
  echo "  * Auto-bumped version to $NEW_VERSION"
  echo
  echo " -- $MAINTAINER_NAME <$MAINTAINER_EMAIL>  $CURRENT_DATE"
  echo
} | cat - "$CHANGELOG_FILE" > temp && mv temp "$CHANGELOG_FILE"

echo "Updated $CHANGELOG_FILE with version $NEW_VERSION"

# Optional: stage and commit changes
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git add "$VERSION_FILE" "$CHANGELOG_FILE"
  git commit -m "chore: bump version to v$NEW_VERSION"
fi
