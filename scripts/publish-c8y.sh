#!/bin/bash

if ! command -V c8y >/dev/null 2>&1; then
    echo "Missing dependency. Please install go-c8y-cli via https://goc8ycli.netlify.app/"
    exit 1
fi

if [ -n "$KAS_MACHINE" ]; then
    MACHINE="$KAS_MACHINE"
else
    MACHINE="${MACHINE:-raspberrypi4-64}"
fi

FIRMWARE_FILE=$(find "build/tmp/deploy/images/$MACHINE" -name "*_*.mender" | tail -1)
if [ -z "$FIRMWARE_FILE" ]; then
    echo "Could not find the .mender image"
    exit 1
fi

FIRMWARE_NAME=$(basename "$FIRMWARE_FILE" | cut -d_ -f1)
FIRMWARE_VERSION=$(basename "$FIRMWARE_FILE" | cut -d_ -f2 | sed 's/\.[a-zA-Z]*$//g')

# Create software name (if it does not already exist)
c8y firmware get -n --id "$FIRMWARE_NAME" --silentStatusCodes 404 >/dev/null || c8y firmware create -n --name "$FIRMWARE_NAME" --delay "1s" --force

c8y firmware versions create --file "$FIRMWARE_FILE" --firmware "$FIRMWARE_NAME" --version "$FIRMWARE_VERSION" "$@"
