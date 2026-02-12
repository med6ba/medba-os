#!/usr/bin/env bash
set -e

# Firewall
systemctl enable --now firewalld

# Automatic updates
systemctl enable --now dnf-automatic.timer

# Dark mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Accent color: gray
gsettings set org.gnome.desktop.interface accent-color 'slate'

# Window buttons: minimize + maximize
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Privacy defaults
gsettings set org.gnome.system.location enabled false
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Flatpak + Flathub
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# =========================
# Set Medba OS identity
# =========================

cat > /etc/os-release << 'EOF'
NAME="Medba OS"
ID=medba
PRETTY_NAME="Medba OS"
VERSION="1.0"
VERSION_ID="1.0"
VARIANT="GNOME"
VARIANT_ID=gnome
HOME_URL="https://medba-os.vercel.app"
EOF

echo "Medba OS (Based on Fedora GNOME)" > /etc/fedora-release

# =========================
# Default wallpaper
# =========================

mkdir -p /usr/share/backgrounds/medba
cp /run/install/repo/assets/wallpaper.png /usr/share/backgrounds/medba/wallpaper.png

# Set wallpaper for GNOME (system default)
gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/medba/wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///usr/share/backgrounds/medba/wallpaper.png"

# =========================
# Remove GNOME / Fedora support banner
# =========================

BRANDING_DIR="/usr/share/gnome-control-center/branding"

mkdir -p $BRANDING_DIR

cat > $BRANDING_DIR/vendor.conf << 'EOF'
[Vendor]
Name=Medba OS
Logo=
Website=https://medba-os.vercel.app
EOF

# =========================
# Third-party apps
# =========================

# Brave Browser (RPM repo)
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y brave-browser

# Discord (Flatpak)
flatpak install -y flathub com.discordapp.Discord

# Fedora Media Writer (Flatpak)
flatpak install -y flathub org.fedoraproject.MediaWriter

# =========================
# Plymouth Boot Splash - Medba OS
# =========================
dnf install -y plymouth

mkdir -p /usr/share/plymouth/themes/medba
cp -a /run/install/repo/assets/plymouth/medba/* /usr/share/plymouth/themes/medba/

plymouth-set-default-theme -R medba
