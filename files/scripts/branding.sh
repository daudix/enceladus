#!/usr/bin/env bash

set -oue pipefail

# Taken from TyrianOS: https://github.com/Icycoide/TyrianOS/blob/54d1df9ad43f7a27ba7c7cb4639b8ac6459052f0/build_files/branding.sh

source /usr/lib/os-release || false

IMAGE_PRETTY_NAME="Enceladus"
IMAGE_LIKE="fedora"
HOME_URL="https://daudix.one/enceladus/"
SUPPORT_URL="https://github.com/daudix/enceladus/issues/"
BUG_SUPPORT_URL="https://github.com/daudix/enceladus/issues/"
CODE_NAME="Lyra"
# VERSION="${VERSION:-00.00000000}"
IMAGE_NAME=enceladus
IMAGE_VENDOR=daudix


# OS Release File
sed -i "s|^NAME=.*|NAME=\"Enceladus\"|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME} ${VERSION} (${CODE_NAME} / FROM Fedora 42 Silverblue)\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"$HOME_URL\"|" /usr/lib/os-release
sed -i "s|^SUPPORT_URL=.*|SUPPORT_URL=\"$SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"$BUG_SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=\"enceladus\"|" /usr/lib/os-release
sed -i "s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"Lyra\"|" /usr/lib/os-release
