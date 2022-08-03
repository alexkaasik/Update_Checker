#!/bin/bash

SNAP=0
FLATPAK=0
Distro=$(cat /etc/*-release | grep "^ID=")
Distro=$(echo "$Distro" | sed -r 's/[ID=]+//g')

case $Distro in
    arch)
        #Arch-pacman
        Packages=$(pacman -Qu | wc -l)
        break
        ;;
    fedora)
        #Fedora-dnf
        Packages=$( dnf  | wc -l)
        break
        ;;
    debian)
        #Debian/Ubuntu-apt
        Packages=$(apt-get list --upgradable | wc -l)
        break
        ;;
    ubuntu)
        #Debian/Ubuntu-apt
        Packages=$(apt-get list --upgradable | wc -l)
        break
        ;;
    *)
        Distro=$(cat /etc/*-release | grep "^ID_LIKE=")
        Distro=$(echo "$Distro" | sed -r 's/[ID_LIKE=]+//g')
        ;;
esac

# Checks if Snaps, How? searches for command named snap
if [ $(ls -al /sbin/ | grep "snap" | wc -l) != 0 ]; then
    #Snap
    SNAP=$(snap refresh --list | wc -l)
fi

# Checks if Flatpak, How? searches for command named flatpak
if [ $(ls -al /sbin/ | grep "snap" | wc -l) != 0 ]; then
    #FlatPak
    FLATPAK=$(flatpak remote-ls --updates | wc -l)
fi

echo "$((Packages+SNAP+FLATPAK)) updates"