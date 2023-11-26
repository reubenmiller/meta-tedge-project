#!/bin/bash

MACHINE="${MACHINE:-raspberrypi4-64}"

FIRMWARE_FILE=$(find "build/tmp/deploy/images/$MACHINE" -name "*.mender" | tail -1)
FIRMWARE_NAME=$(basename "$FIRMWARE_FILE" | cut -d_ -f1)
FIRMWARE_VERSION=$(basename "$FIRMWARE_FILE" | cut -d_ -f2 | sed 's/\.[a-zA-Z]*$//g')

c8y firmware versions create --file "$FIRMWARE_FILE" --firmware "$FIRMWARE_NAME" --version "$FIRMWARE_VERSION" "$@"
