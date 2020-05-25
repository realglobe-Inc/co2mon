#!/bin/sh

image="${HOME}/Downloads/2020-02-13-raspbian-buster-lite.img"

sudo printf ''  # sudoをいちどキックしておく

while :; do
  echo "waiting /Volumes/boot ..."
  test -d /Volumes/boot && break
  sleep 1
done
echo "/Volumes/boot found!"

diskutil unmountDisk /dev/disk2

echo "ディスクイメージを書き込みます..."
dd if="${image}" bs=1m | pv | sudo dd of=/dev/rdisk2 bs=1m
say 'オワッタヨ'

while :; do
  echo "waiting /Volumes/boot ..."
  test -d /Volumes/boot && break
  sleep 1
done
echo "/Volumes/boot found!"

touch /Volumes/boot/ssh
diskutil eject /dev/disk2
