#!/bin/bash

set -e

echo "== Clean environment =="
wineserver -k 2>/dev/null || true
rm -rf ~/.wine ~/.cache/wine ~/wine

sudo rm -f /usr/local/bin/wine*
sudo rm -rf /usr/local/bin/wine

echo "== Download Wine 5.0.4 i386 =="
cd ~/Downloads

wget https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-stable-i386_6.0.0~buster-1_i386.deb
wget https://dl.winehq.org/wine-builds/debian/dists/buster/main/binary-i386/wine-stable_6.0.0~buster-1_i386.deb
echo "== Extract packages =="
rm -rf wine-installer
mkdir wine-installer

dpkg-deb -x wwine-stable-i386_6.0.0~buster-1_i386.deb wine-installer
dpkg-deb -x wine-stable_6.0.0~buster-1_i386.deb wine-installer

echo "== Install ke ~/wine =="
mv wine-installer/opt/wine* ~/wine

rm wine-stable*.deb
rm -rf wine-installer

echo "== Setup launcher (Box86) =="

echo '#!/bin/bash
setarch linux32 -L $HOME/wine/bin/wine "$@"' | sudo tee /usr/local/bin/wine >/dev>

sudo ln -sf $HOME/wine/bin/wineboot /usr/local/bin/wineboot
sudo ln -sf $HOME/wine/bin/winecfg /usr/local/bin/winecfg
sudo ln -sf $HOME/wine/bin/wineserver /usr/local/bin/wineserver

sudo chmod +x /usr/local/bin/wine /usr/local/bin/wineboot /usr/local/bin/winecfg >

echo "== Install dependency ARMHF =="
sudo dpkg --add-architecture armhf
sudo apt update

sudo apt install -y \
libc6:armhf libstdc++6:armhf \
libx11-6:armhf libxext6:armhf libxrender1:armhf libxrandr2:armhf \
libxcursor1:armhf libxi6:armhf libxinerama1:armhf \
libasound2:armhf libpulse0:armhf \
libglib2.0-0:armhf libfreetype6:armhf \
libfontconfig1:armhf libgnutls30:armhf \
libopenal1:armhf libldap-2.4-2:armhf \
libgphoto2-6:armhf libgphoto2-port12:armhf \
libpcap0.8:armhf libusb-1.0-0:armhf \
libv4l-0:armhf libudev1:armhf \
libncurses6:armhf \
libwine:armhf

echo "== Fix runtime dir =="
export XDG_RUNTIME_DIR=/tmp/runtime-$USER
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

echo "== Verifikasi binary =="
file ~/wine/bin/wine

echo "== Init Wine =="
box86 wineboot --init

echo "== DONE =="
