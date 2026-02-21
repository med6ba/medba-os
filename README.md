# Medba OS

Medba OS is a lightweight custom Linux distribution built from scratch for learning and experimentation.  
It demonstrates the full path from kernel and root filesystem to a bootable ISO image.

![Status](https://img.shields.io/badge/Status-Bootable-brightgreen)
![Kernel](https://img.shields.io/badge/Kernel-6.19.0-blue)
![Architecture](https://img.shields.io/badge/Architecture-x86__64-orange)
![GitHub repo size](https://img.shields.io/github/repo-size/med6ba/medba-downloader)
![GitHub license](https://img.shields.io/github/license/med6ba/medba-downloader)

## Highlights

- Custom Linux kernel integration (`bzImage` + GRUB boot flow)
- Minimal BusyBox-based userspace
- Handcrafted init sequence (`rootfs/init`)
- ISO image generation for VM testing (QEMU/Boxes)

## Prerequisites

Install the required host packages for your distribution:

| Distribution | Install Command |
| --- | --- |
| ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?logo=ubuntu&logoColor=white) ![Debian](https://img.shields.io/badge/Debian-A81D33?logo=debian&logoColor=white) | `sudo apt install qemu-system-x86 xorriso mtools grub-pc-bin` |
| ![Fedora](https://img.shields.io/badge/Fedora-51A2DA?logo=fedora&logoColor=white) | `sudo dnf install qemu-system-x86 xorriso mtools grub2-pc-modules grub2-tools` |
| ![Arch Linux](https://img.shields.io/badge/Arch-1793D1?logo=arch-linux&logoColor=white) | `sudo pacman -S qemu-desktop xorriso mtools grub` |

## Quick Start

Run the prebuilt ISO with QEMU:

```bash
qemu-system-x86_64 -cdrom MedbaOS.iso -m 512M
```

## Rebuild

Use the build script:

```bash
./build.sh
```

Or rebuild manually:

```bash
cd rootfs
find . | cpio -o -H newc | gzip > ../iso/boot/initrd.img
cd ..
grub2-mkrescue -o MedbaOS.iso iso/
```

## Project Layout

```text
.
├── build.sh
├── iso/
├── kernel_src/
├── rootfs/
├── bzImage
└── MedbaOS.iso
```

## Notes

- This is a minimal educational operating system project.
- Inspired by: [YouTube reference](https://youtu.be/CvZ01fWkAJE)
- Built and tested on: ![Fedora](https://img.shields.io/badge/Fedora-294172?logo=fedora&logoColor=white)

![Stars](https://img.shields.io/github/stars/med6ba/medba-downloader?logo=github) ![Forks](https://img.shields.io/github/forks/med6ba/medba-downloader?logo=github)
