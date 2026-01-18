#!/usr/bin/env bash

# Usage: ./update-formula.sh <repo_user/repo_name> <formula name>
# Example: ./update-formula.sh bthuilot/ggh ggh

REPO=$1
FORMULA=$2

err() {
  echo "ERROR: $1"
  exit 1
}

if [[ -z "${REPO}" ]] || [[ -z "${FORMULA}" ]]
then
  echo "Usage: $0 <user/repo> <formula>"
  exit 1
fi

FORMULA_PATH="Formula/${FORMULA}.rb"

RELEASE_URL="https://github.com/${REPO}/releases/latest"

LATEST_RELEASE_LINK=$(curl -fsS -w '%header{location}' -o /dev/null "${RELEASE_URL}" || err "unable to get latest release headers")

TAG=$(echo "${LATEST_RELEASE_LINK}" | awk -F '/' '{print $NF}')

echo "found latest tag: ${TAG}"

SOURCEURL="https://github.com/${REPO}/archive/refs/tags/${TAG}.tar.gz"

echo "Fetching ${SOURCEURL}..."

# shellcheck disable=SC2312
SOURCE_TGZ_SHA256=$(curl -fsSL "${SOURCEURL}" | sha256sum)
SHA256="${SOURCE_TGZ_SHA256/% -/}"

if [[ -z "${SHA256}" ]]
then
  echo "Error: Could not calculate SHA256."
  exit 1
fi

VERSION=${TAG/#v/}

echo "found latest version ${VERSION} with SHA256: ${SHA256}"

sed -i '' "s|VERSION = \"[0-9\.]\"|VERSION = \"${VERSION}\"|" "${FORMULA_PATH}"
sed -i '' "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "${FORMULA_PATH}"

echo "Successfully updated ${FORMULA_PATH} to version ${VERSION}"
