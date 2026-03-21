#!/bin/bash

DISK="/dev/mmcblk1"
PART="2"
DEV="${DISK}p${PART}"

echo "== Install Cloud Utils =="

sudo apt-get install cloud-utils -y

echo "== Growing Partition =="

sudo growpart ${DISK} ${PART}

echo "== Resize Partition =="

sleep 2

sudo resize2fs ${DEV}

echo "== Done =="
