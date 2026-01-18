#!/usr/bin/env bash

# Usage: ./update-formula.sh <repo_user/repo_name> <formula name>
# Example: ./update-formula.sh bthuilot/ggh ggh

REPO=$1
FORMULA=$2

if [ -z "$REPO" ] || [ -z "$FORMULA" ]; then
    echo "Usage: $0 <user/repo> <formula>"
    exit 1
fi

FORMULA_PATH="Formula/${FORMULA}.rb"

RELEASE_URL="https://github.com/${REPO}/releases/latest"

TAG=$(curl -sS -D -  -o /dev/null "$RELEASE_URL" | grep "location: " | awk -F '/' '{print $NF}' | tr -d '\r')

echo "found latest tag: $TAG"

SOURCEURL="https://github.com/${REPO}/archive/refs/tags/${TAG}.tar.gz"

echo "Fetching ${SOURCEURL}..."

SHA256=$(curl -L -sS "$SOURCEURL" | sha256sum | awk '{print $1}')

if [ -z "$SHA256" ]; then
    echo "Error: Could not calculate SHA256."
    exit 1
fi

VERSION=$(echo "$TAG" | sed 's/^v//')

echo "found latest version ${VERSION} with SHA256: $SHA256"

sed -i '' "s|VERSION = '[0-9\.]'|VERSION = '${VERSION}'|" "$FORMULA_PATH"
sed -i '' "s|sha256 '.*'|sha256 '$SHA256'|" "$FORMULA_PATH"

echo "Successfully updated $FORMULA_PATH to version $VERSION"