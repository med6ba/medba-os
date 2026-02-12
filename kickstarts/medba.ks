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

clearpart --all --initlabel
part / --fstype="xfs" --size=12000
part swap --fstype="swap" --size=2048

reboot

%packages
@workstation-product-environment
dracut-live

# Media
vlc

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
