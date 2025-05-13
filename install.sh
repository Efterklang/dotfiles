#!/usr/bin/env bash

set -e

# Detect OS and set the appropriate config file
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Detected macOS"
  CONFIG="mac.yaml"
else
  echo "Detected Linux"
  CONFIG="linux.yaml"
fi

DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
