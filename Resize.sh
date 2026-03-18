#!/bin/bash

DISK="/dev/mmcblk1"
PART="2"
DEV="${DISK}p${PART}"

echo "== Force resize partition =="

echo ", +" | sfdisk --force -N ${PART} ${DISK}

echo "== Reload partition table =="

partprobe ${DISK} || true

sleep 2

echo "== Resize filesystem =="

resize2fs ${DEV} || echo "Resize after reboot required"

echo "== Done =="