#!/bin/bash

FILE_EXT=${FILE_EXT:-raucb}

if [ $# -gt 0 ]; then
    FILE_EXT="$1"
    shift
fi

if ! command -V c8y >/dev/null 2>&1; then
    echo "Missing dependency. Please install go-c8y-cli via https://goc8ycli.netlify.app/" >&2
    exit 1
fi

if [ -n "$KAS_MACHINE" ]; then
    MACHINE="$KAS_MACHINE"
else
    MACHINE="${MACHINE:-raspberrypi4-64}"
fi

SEARCH_DIR="build/tmp/deploy/images/$MACHINE"
echo "Searching for *.$FILE_EXT files under $SEARCH_DIR" >&2
FIRMWARE_FILE=$(find "$SEARCH_DIR" -name "*_*.$FILE_EXT" | tail -1)
if [ -z "$FIRMWARE_FILE" ]; then
    echo "Could not find the .$FILE_EXT image" >&2
    exit 1
fi

FIRMWARE_NAME=$(basename "$FIRMWARE_FILE" | cut -d_ -f1)
FIRMWARE_VERSION=$(basename "$FIRMWARE_FILE" | cut -d_ -f2 | sed 's/\.[a-zA-Z]*$//g')

echo "Found firmware. name=$FIRMWARE_NAME, version=$FIRMWARE_VERSION, file=$FIRMWARE_FILE" >&2

# Create software name (if it does not already exist)
c8y firmware get -n --id "$FIRMWARE_NAME" --silentStatusCodes 404 >/dev/null \
    || c8y firmware create -n --name "$FIRMWARE_NAME" --delay "1s" --force

c8y firmware versions get -n --firmware "$FIRMWARE_NAME" --id "$FIRMWARE_VERSION" --silentStatusCodes 404 >/dev/null \
    || c8y firmware versions create -n --file "$FIRMWARE_FILE" --firmware "$FIRMWARE_NAME" --version "$FIRMWARE_VERSION" --force "$@"
