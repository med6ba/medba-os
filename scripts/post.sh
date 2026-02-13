#!/usr/bin/env bash
set -euo pipefail

# Log everything (very helpful if something fails)
exec > >(tee -a /root/medba-post.log) 2>&1

echo "[Medba OS] Post-install started..."

# -------------------------
# Services
# -------------------------
echo "[Medba OS] Enabling firewall..."
systemctl enable --now firewalld || true

echo "[Medba OS] Enabling automatic updates..."
systemctl enable --now dnf-automatic.timer || true

# -------------------------
# Set Medba OS identity
# -------------------------
echo "[Medba OS] Setting OS identity..."
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

# Optional (nice touch)
echo "Medba OS" > /etc/issue
echo "Medba OS" > /etc/issue.net

# -------------------------
# Default wallpaper
# -------------------------
echo "[Medba OS] Installing default wallpaper..."
mkdir -p /usr/share/backgrounds/medba

if [ -f /run/install/repo/assets/wallpaper.png ]; then
  cp /run/install/repo/assets/wallpaper.png /usr/share/backgrounds/medba/wallpaper.png
else
  echo "[Medba OS] WARNING: assets/wallpaper.png not found in repo. Skipping wallpaper."
fi

# -------------------------
# GNOME defaults (system-wide) via dconf
# -------------------------
echo "[Medba OS] Writing GNOME defaults via dconf..."
mkdir -p /etc/dconf/db/local.d

cat > /etc/dconf/db/local.d/00-medba << 'EOF'
[org/gnome/desktop/interface]
color-scheme='prefer-dark'
accent-color='slate'

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'

[org/gnome/system/location]
enabled=false

[org/gnome/desktop/privacy]
send-software-usage-stats=false
remember-recent-files=false

[org/gnome/desktop/background]
picture-uri='file:///usr/share/backgrounds/medba/wallpaper.png'
picture-uri-dark='file:///usr/share/backgrounds/medba/wallpaper.png'
EOF

dconf update || true

# -------------------------
# Remove GNOME / Fedora support banner (vendor branding)
# -------------------------
echo "[Medba OS] Setting GNOME Control Center vendor branding..."
BRANDING_DIR="/usr/share/gnome-control-center/branding"
mkdir -p "$BRANDING_DIR"

cat > "$BRANDING_DIR/vendor.conf" << 'EOF'
[Vendor]
Name=Medba OS
Logo=
Website=https://medba-os.vercel.app
EOF

# -------------------------
# Flatpak + Flathub
# -------------------------
echo "[Medba OS] Setting up Flatpak + Flathub..."
dnf install -y flatpak || true

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
flatpak remotes || true

# -------------------------
# Third-party apps
# -------------------------
echo "[Medba OS] Installing Brave (RPM repo)..."
dnf install -y dnf-plugins-core || true
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo || true
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc || true
dnf install -y brave-browser || true

echo "[Medba OS] Installing Discord (Flatpak)..."
flatpak install -y --noninteractive flathub com.discordapp.Discord || true

echo "[Medba OS] Installing Fedora Media Writer (Flatpak)..."
flatpak install -y --noninteractive flathub org.fedoraproject.MediaWriter || true

# -------------------------
# Plymouth Boot Splash - Medba OS
# -------------------------
echo "[Medba OS] Installing Plymouth theme..."
dnf install -y plymouth || true

if [ -d /run/install/repo/assets/plymouth/medba ]; then
  mkdir -p /usr/share/plymouth/themes/medba
  cp -a /run/install/repo/assets/plymouth/medba/* /usr/share/plymouth/themes/medba/
  plymouth-set-default-theme -R medba || true
else
  echo "[Medba OS] WARNING: assets/plymouth/medba/ not found. Skipping Plymouth theme."
fi

echo "[Medba OS] Post-install finished."
