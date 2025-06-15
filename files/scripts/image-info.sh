#!/usr/bin/env bash
# Taken from Bluefin: https://github.com/ublue-os/bluefin/blob/6c348bd54eca6949d07d8f310cb1ded53d4943ed/build_files/base/00-image-info.sh

set -ouex pipefail

IMAGE_PRETTY_NAME="Enceladus"
IMAGE_LIKE="fedora"
HOME_URL="https://github.com/daudix/enceladus"
DOCUMENTATION_URL="https://github.com/daudix/enceladus"
SUPPORT_URL="https://github.com/daudix/enceladus/issues/"
BUG_SUPPORT_URL="https://github.com/daudix/enceladus/issues/"
CODE_NAME="Lyra"
VERSION="${VERSION:-00.00000000}"

IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_REF="ostree-image-signed:docker://ghcr.io/$IMAGE_VENDOR/$IMAGE_NAME"

cat >$IMAGE_INFO <<EOF
{
  "image-name": "$IMAGE_NAME",
  "image-flavor": "$image_flavor",
  "image-vendor": "$IMAGE_VENDOR",
  "image-ref": "$IMAGE_REF",
  "image-tag":"$UBLUE_IMAGE_TAG",
  "base-image-name": "$BASE_IMAGE_NAME",
  "fedora-version": "$FEDORA_MAJOR_VERSION"
}
EOF

# OS Release File
sed -i "s|^VARIANT_ID=.*|VARIANT_ID=$IMAGE_NAME|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME} ${CODE_NAME}\"|" /usr/lib/os-release
sed -i "s|^NAME=.*|NAME=\"$IMAGE_PRETTY_NAME\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"$HOME_URL\"|" /usr/lib/os-release
sed -i "s|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL=\"$DOCUMENTATION_URL\"|" /usr/lib/os-release
sed -i "s|^SUPPORT_URL=.*|SUPPORT_URL=\"$SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"$BUG_SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=\"${IMAGE_PRETTY_NAME,}\"|" /usr/lib/os-release
sed -i "s|^ID=fedora|ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"|" /usr/lib/os-release
sed -i "/^REDHAT_BUGZILLA_PRODUCT=/d; /^REDHAT_BUGZILLA_PRODUCT_VERSION=/d; /^REDHAT_SUPPORT_PRODUCT=/d; /^REDHAT_SUPPORT_PRODUCT_VERSION=/d" /usr/lib/os-release
sed -i "s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"$CODE_NAME\"|" /usr/lib/os-release
sed -i "s|^VERSION=.*|VERSION=\"${VERSION} (${BASE_IMAGE_NAME^})\"|" /usr/lib/os-release
sed -i "s|^OSTREE_VERSION=.*|OSTREE_VERSION=\'${VERSION}\'|" /usr/lib/os-release

if [[ -n "${SHA_HEAD_SHORT:-}" ]]; then
  echo "BUILD_ID=\"$SHA_HEAD_SHORT\"" >>/usr/lib/os-release
fi

# Added in systemd 249.
# https://www.freedesktop.org/software/systemd/man/latest/os-release.html#IMAGE_ID=
echo "IMAGE_ID=\"${IMAGE_NAME}\"" >> /usr/lib/os-release
echo "IMAGE_VERSION=\"${VERSION}\"" >> /usr/lib/os-release

# Fix issues caused by ID no longer being fedora
sed -i "s|^EFIDIR=.*|EFIDIR=\"fedora\"|" /usr/sbin/grub2-switch-to-blscfg
