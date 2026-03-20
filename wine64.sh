# Bersihkan prefix lama
rm -rf ~/.wine
rm -rf ~/wine

cd ~

# Download Wine terbaru (staging + wow64)
wget https://github.com/Kron4ek/Wine-Builds/releases/download/11.4/wine-11.4-staging-amd64-wow64.tar.xz

# Buat folder wine
mkdir ~/wine
cd ~/wine

# Extract
tar -xvf ../wine-11.4-staging-amd64-wow64.tar.xz

# Hapus symlink lama (hindari error wineserver mismatch)
sudo rm -f /usr/local/bin/wine
sudo rm -f /usr/local/bin/wine64
sudo rm -f /usr/local/bin/wineserver
sudo rm -f /usr/local/bin/winecfg
sudo rm -f /usr/local/bin/wineboot

# Masuk ke folder hasil extract
cd wine-11.4-staging-amd64-wow64/

# Buat symlink baru
sudo ln -s ~/wine/wine-11.4-staging-amd64-wow64/bin/wine /usr/local/bin/wine
sudo ln -s ~/wine/wine-11.4-staging-amd64-wow64/bin/wine64 /usr/local/bin/wine64
sudo ln -s ~/wine/wine-11.4-staging-amd64-wow64/bin/wineserver /usr/local/bin/wineserver
sudo ln -s ~/wine/wine-11.4-staging-amd64-wow64/bin/winecfg /usr/local/bin/winecfg
sudo ln -s ~/wine/wine-11.4-staging-amd64-wow64/bin/wineboot /usr/local/bin/wineboot

cd ~

# Hapus file archive
rm wine-11.4-staging-amd64-wow64.tar.xz

echo "Wine 11.4 staging (wow64) installed"
echo "Test dengan:"
echo "box64 winecfg"
