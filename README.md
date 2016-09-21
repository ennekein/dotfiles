# My dot files

## setup

*Ubuntu 16.04.1 LTS (Xenial Xerus) Server minimal install*


with the following packages:

    i3 lxterminal rxvt-unicode-256color lightdm
    x11-xserver-utils
    rofi compton conky feh
    fonts-inconsolata fonts-powerline fonts-font-awesome

## other software

### packages

    usbmount vpnc firefox remmina cryptsetup uzbl gnome-calculator

### Arc GTK Theme

    wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
    sudo apt-key add - < Release.key
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
    sudo apt-get update && sudo apt-get install arc-theme lxappearance

Then choose Arc-Darker in lxappearance.
From http://www.omgubuntu.co.uk/2016/06/install-latest-arc-gtk-theme-ubuntu-16-04

### powerline font

     cd /usr/share/fonts/truetype/
     sudo wget https://github.com/powerline/fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf?raw=1
     mv Inconsolata\ for\ Powerline.otf\?raw=1 Inconsolata\ for\ Powerline.otf
     fc-cache -f .

### chrome

     wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
     sudo add-apt-repository -y "deb http://dl.google.com/linux/chrome/deb/ stable main"
     sudo apt-get install google-chrome-stable

### atom

    wget https://github.com/atom/atom/releases/download/v1.9.8/atom-amd64.deb
    sudo dpkg --install atom-amd64.deb
    sudo apt-get -f install

### steam

    sudo apt-get install steam
    cd $HOME/.steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu
    mv libstdc++.so.6 libstdc++.so.6.bak
    cd $HOME/.steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu
    mv libstdc++.so.6 libstdc++.so.6.bak


## iphone
Communicate with iPhone using http://www.libimobiledevice.org/. The 16.04.1 repo pacakage are out of date, we need to install from source.

### Install from source

    sudo apt install build-essential automake libxml++2.6-dev libtool python-dev libssl-dev libfuse-dev libzip-de
    git clone https://github.com/libimobiledevice/ideviceinstaller
    git clone https://github.com/libimobiledevice/ifuse
    git clone https://github.com/libimobiledevice/libimobiledevice
    git clone https://github.com/libimobiledevice/libplist
    git clone https://github.com/libimobiledevice/libusbmuxd

### Pair device

    idevicepair -u $(idevice_id -l) pair

### mount iphone
    chmod 775 /media/iphone
    ifuse /media/iphone -u  $(idevice_id -l)

### mount application data
    ifuse --documents $(ideviceinstaller -l | awk -F, '/Mercury/ {print $1}') /media/iphone_mercury/



## credits
### .conky
https://github.com/ThatJames/Conky

### conky for i3Bar
http://pastebin.com/h1g6FTD6


### 3wm: How To
https://www.youtube.com/playlist?list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf
