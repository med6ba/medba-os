# =========================
# Medba OS - Fedora GNOME
# =========================

lang en_US.UTF-8
keyboard us
timezone UTC --utc

network --bootproto=dhcp --device=link --activate

selinux --enforcing
firewall --enabled

autopart --type=lvm
clearpart --all --initlabel

reboot

%packages
@workstation-product-environment

# Browsers
brave-browser

# Media
vlc

# Communication
discord

# Utilities
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
fedora-media-writer
cheese

# Packaging
flatpak

# Remove unwanted
-gnome-tour
%end

%post --log=/root/medba-post.log
mkdir -p /root/medba
cp -a /run/install/repo/scripts/post.sh /root/medba/post.sh
chmod +x /root/medba/post.sh
bash /root/medba/post.sh
%end
