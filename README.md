# 🚀 Medba OS (v1.0)

**Medba OS** is a lightweight, custom Linux distribution built entirely from scratch. This project demonstrates the core mechanics of the Linux kernel, the boot process, and how a minimal RootFS interacts with the system to provide a functional shell.

![Status](https://img.shields.io/badge/Status-Live%20&%20Bootable-brightgreen)
![Kernel](https://img.shields.io/badge/Kernel-6.19.0-blue)
![Architecture](https://img.shields.io/badge/Arch-x86__64-orange)

---

## 🛠️ Features
- **Custom Kernel Build:** Optimized Linux kernel configuration based on version 6.19.0.
- **BusyBox Powered:** Provides a complete suite of standard UNIX utilities in a single binary.
- **Handcrafted Init Script:** A custom boot script managing essential mounts (proc, sys, dev) and shell execution.
- **GRUB Bootloader:** Fully configured for reliable ISO booting.

---

## 📦 Prerequisites

To run or rebuild Medba OS, you need QEMU and xorriso installed on your host system. Use the command for your distribution:

#### Ubuntu / Debian
sudo apt install qemu-system-x86 xorriso mtools grub-pc-bin

#### Fedora
sudo dnf install qemu-system-x86 xorriso mtools grub2-pc-modules grub2-tools

#### Arch Linux
sudo pacman -S qemu-desktop xorriso mtools grub

---

## 🚀 How to Run

You don't need to install the OS. Just execute the pre-built ISO using QEMU:

qemu-system-x86_64 -cdrom MedbaOS.iso -m 512M

---

## 📂 Project Structure
- kernel_src/: Full Linux kernel source code.
- rootfs/: The root filesystem containing the init script, bin/ (BusyBox), and system mount points.
- iso/: The staging area for the bootable image.
- MedbaOS.iso: The final bootable ISO file.

---

## 🛠️ How to Rebuild
If you modify the rootfs, update the ISO as follows:

1. Pack the Initrd:
cd rootfs
find . | cpio -o -H newc | gzip > ../iso/boot/initrd.img

2. Generate the ISO:
cd ..
grub2-mkrescue -o MedbaOS.iso iso/

---
*Disclaimer: This is a minimal OS for educational purposes.*
