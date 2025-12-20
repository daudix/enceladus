# Enceladus

[![enceladus build badge](https://github.com/daudix/enceladus/actions/workflows/build.yml/badge.svg)](https://github.com/daudix/enceladus/actions/workflows/build.yml)

My personal flavors of [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) and [uCore](https://github.com/ublue-os/ucore). They includes a small amount of chnages that I always do on my own systems:

- Both
  - Installs [1.1.1.1](https://one.one.one.one)
  - Installs [fish shell](https://fishshell.com)
- Fedora Silverblue
  - Adds all neccesary media codecs and thumbnailers
  - Installs [Extension Manager](https://flathub.org/apps/com.mattjakeman.ExtensionManager)
  - Installs all core GNOME apps
  - Removes default Fedora wallpapers
  - Removes Firefox RPM
  - Removes GNOME Classic session
  - Replaces Fedora Flatpaks with the ones from Flathub
  - Replaces Sushi Flatpak with system package, so that it can make use of additional codecs
- uCore
  - Replaces Moby Docker with Docker-CE
  - Installs [TuneD](https://tuned-project.org)

As these images are for personal use, I can't guarantee that their scope won't change, in fact it *will* quite often, as I change my own scope just as often.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

Enceladus has two variants:

 - `latte` - Silverblue-based image (alternatively `desktop`)
 - `espresso` - uCore-based image (alternatively `server`)

To rebase an existing atomic Fedora installation to the latest build of select variant:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/daudix/enceladus:<VARIANT>
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/daudix/enceladus:<VARIANT>
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/daudix/enceladus
```
