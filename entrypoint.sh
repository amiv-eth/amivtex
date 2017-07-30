#!/bin/bash
# Custom entrypoint to download and unpack fonts
# This is required since Docker secrets cannot be directories

# Create font directory
mkdir -p /usr/share/fonts

# Read URL to download font from app config, download with curl and unpack
# TODO: Maybe this can be done a bit more efficiently
wget -qO- $(cat $FONT_URL) \
    | tar -xzC /usr/share/fonts --strip-components=1

# Execute CMD
exec "$@"
