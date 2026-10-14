#!/bin/bash
set -e

# 1. Limpieza de montajes previos
sudo umount -R /mnt/sysimage 2>/dev/null || true
sudo losetup -D 2>/dev/null || true
sudo rm -rf /var/tmp/cdos-build

# 2. Asegurar que udisks2 está activo
sudo systemctl start udisks2.service

# 3. SELinux en modo Permissive durante la compilación
sudo setenforce 0

# 4. Aislar la propagación de montajes para que el host no bloquee el chroot
sudo mount --make-rprivate /

echo "Iniciando compilación de CDOS Linux ISO..."

# 5. Ejecución limpia de livemedia-creator
sudo livemedia-creator \
  --ks=/home/builder/cdos-workspace/flat-cdos.ks \
  --project="CDOS" \
  --releasever=1.0 \
  --volid="CDOS-1.0" \
  --make-iso \
  --no-virt \
  --iso-only \
  --iso-name="CDOS-1.0-x86_64.iso" \
  --resultdir=/var/tmp/cdos-build

# 6. Restaurar SELinux
sudo setenforce 1

echo "=========================================================="
echo "CDOS ISO generada con éxito en /var/tmp/cdos-build/"
echo "=========================================================="
