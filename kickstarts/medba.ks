# =========================
# Medba OS - Fedora GNOME
# =========================

url --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-43&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-43&arch=$basearch

lang en_US.UTF-8
keyboard us
timezone UTC --utc

network --bootproto=dhcp --device=link --activate

selinux --enforcing
firewall --enabled

# Partitions (for build image only)
clearpart --all --initlabel
part / --fstype="xfs" --size=25000
part swap --fstype="swap" --size=2048

reboot

%packages
@workstation-product-environment

# Live ISO build essentials
dracut-live
squashfs-tools
xorriso

# Bootloader: BIOS + UEFI
grub2-tools
grub2-pc
grub2-pc-modules

shim-x64
grub2-efi-x64
grub2-efi-x64-modules
grub2-tools-efi
grub2-efi-x64-cdboot

# System services
firewalld
dnf-automatic
flatpak

# Needed for system-wide GNOME defaults
dconf
glib2

# Media
vlc

# Utilities / GNOME apps (your list)
gnome-calculator
gnome-calendar
gnome-clocks
gnome-logs
gnome-contacts
gnome-system-monitor
gnome-disk-utility
baobab
evince
eog
simple-scan
gnome-font-viewer
gnome-characters
gnome-help
gnome-connections
gnome-boxes
gnome-weather
gnome-maps
cheese

# Remove unwanted
-gnome-tour
%end

%post --log=/root/medba-post.log
set -euo pipefail

mkdir -p /root/medba
cp -a /run/install/repo/scripts/post.sh /root/medba/post.sh
chmod +x /root/medba/post.sh

bash /root/medba/post.sh
%end
