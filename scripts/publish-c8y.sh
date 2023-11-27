#!/bin/bash

if ! command -V c8y >/dev/null 2>&1; then
    echo "Missing dependency. Please install go-c8y-cli via https://goc8ycli.netlify.app/"
    exit 1
fi

MACHINE="${MACHINE:-raspberrypi4-64}"

FIRMWARE_FILE=$(find "build/tmp/deploy/images/$MACHINE" -name "*.mender" | tail -1)
if [ -z "$FIRMWARE_FILE" ]; then
    echo "Could not find the .mender image"
    exit 1
fi

FIRMWARE_NAME=$(basename "$FIRMWARE_FILE" | cut -d_ -f1)
FIRMWARE_VERSION=$(basename "$FIRMWARE_FILE" | cut -d_ -f2 | sed 's/\.[a-zA-Z]*$//g')

c8y firmware versions create --file "$FIRMWARE_FILE" --firmware "$FIRMWARE_NAME" --version "$FIRMWARE_VERSION" "$@"
