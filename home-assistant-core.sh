#!/data/data/com.termux/files/usr/bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/source.env"

# The script will find and download the image from Docker Hub, not from GitHub Container Registry
#IMAGE_NAME="homeassistant/home-assistant:2025.6"
#IMAGE_NAME="homeassistant/home-assistant:2025.11.3"
#IMAGE_NAME="ghcr.io/adyoull/ha-armv7:2026.7.2"
#IMAGE_NAME="dockergzs/hass-core:python3.14-alpine3.24-2026.7.2-armv7"
IMAGE_NAME="ghcr.io/villgzs/hass-core32:armv7-2026.9.3"
CONTAINER_NAME="home-assistant-core"

# Set timezone, eg, Asia/Seoul. Feel free to change.
TZ="Europe/Budapest"

# Set storage path for Home Assistant configuration
STORAGE_PATH="$(pwd)/haconfig"
mkdir -p "$STORAGE_PATH"

# Check if PORT is a valid number; default to 8123 if not provided
case $PORT in
  ''|*[!0-9]*) PORT=8123;;
  *) [ $PORT -gt 1023 ] && [ $PORT -lt 65536 ] || PORT="8123";;
esac

# Ensure udocker environment is set up
echo check
udocker_check

# Clean up unused containers and images
echo prune
udocker_prune

# Create the Home Assistant container
echo create
udocker_create "$CONTAINER_NAME" "$IMAGE_NAME"

# If arguments are passed, run them directly in the container
if [ -n "$1" ]; then
 udocker_run --entrypoint "bash -c" -p "$PORT:8123" "$CONTAINER_NAME" "$@"
else
  # Default run command for Home Assistant with configuration
  echo run
 udocker_run -p "$PORT:8123" \
   -e TZ="$TZ" \
   -v "$STORAGE_PATH:/config" \
   -v "$(pwd)/alcatel_udocker_util.py:/usr/src/homeassistant/homeassistant/components/network/util.py" \
  "$CONTAINER_NAME" \
  bash -c 'exec python3 -m homeassistant --config /config'
fi
exit $?
