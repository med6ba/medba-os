#!/bin/bash

# 1. المجلد الرئيسي
BASE_DIR=~/Desktop/medba-os
cd $BASE_DIR

echo "🛠️  Starting Medba OS Build..."

# 2. جمع الـ rootfs (القلب ديال السيستيم)
echo "📦 Packing rootfs into initrd.img..."
cd rootfs
find . | cpio -o -H newc | gzip > ../iso/boot/initrd.img
cd ..

# 3. صنع الـ ISO (اللي غاتعطيه لـ Boxes)
echo "💿 Generating MedbaOS.iso..."
grub2-mkrescue -o MedbaOS.iso iso/

echo "---------------------------------------"
echo "✅ Done! Your ISO is ready at:"
echo "$BASE_DIR/MedbaOS.iso"
echo "---------------------------------------"
