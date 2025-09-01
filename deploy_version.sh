#!/bin/bash
set -e

# Check argument
if [ -z "$1" ]; then
  echo "Usage: $0 <new-version>"
  exit 1
fi

NEW_VERSION="$1"

# Validate version format (basic semantic version check)
if [[ ! "$NEW_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Version must be in format X.Y.Z"
  exit 1
fi

# Update pubspec.yaml (only change the 'version:' line)
sed -i.bak "s/^version: .*/version: $NEW_VERSION/" pubspec.yaml
rm pubspec.yaml.bak

echo "Updated pubspec.yaml to version $NEW_VERSION"

# Commit changes
git add pubspec.yaml
git commit -m "chore: bump version to $NEW_VERSION"

# Create git tag
TAG="v$NEW_VERSION"
git tag "$TAG"

git push
git push --tags

echo "Created git tag $TAG and pushed changes to remote repository"
