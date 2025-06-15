#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 -y copr enable sentry/kernel-blu
echo "exclude=kernel*" >> /etc/yum.repos.d/fedora-updates.repo
dnf5 -y copr enable miokudev/fjordlauncherunlocked
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 -y copr enable swayfx/swayfx 
dnf5 -y install swayfx fjordlauncher curl wget git xorg-x11-drv-nvidia-cuda akmod-nvidia flatpak
mkdir /usr/local/bin/swayfx-nvidia
mkdir /usr/share/wayland-sessions
mkdir /usr/local/share/wlroots-nvidia/wlroots-env-nvidia.sh
wget -P "/usr/local/bin/swayfx-nvidia" https://raw.githubusercontent.com/meeplabsdev/swayfx-nvidia/refs/heads/main/swayfx-nvidia.sh
wget -P "/usr/share/wayland-sessions/swayfx-nvidia.desktop" https://raw.githubusercontent.com/meeplabsdev/swayfx-nvidia/refs/heads/main/swayfx-nvidia.desktop
wget -P "/usr/local/share/wlroots-nvidia/wlroots-env-nvidia.sh" https://raw.githubusercontent.com/meeplabsdev/swayfx-nvidia/refs/heads/main/wlroots-env-nvidia.sh
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo --assumeyes
flatpak install flathub org.vinegarhq.Sober --assumeyes 
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
