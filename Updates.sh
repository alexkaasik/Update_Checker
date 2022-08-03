#!/bin/bash

Distro=$(cat /etc/*-release | grep "^ID=")
Distro=$(echo "$Distro" | sed -r 's/[ID=]+//g')

case $Distro in
    arch)
        #Arch-pacman
        sudo pacman -Syu --noconfirm
        break
        ;;
    fedora)
        #Fedora-dnf
        sudo dnf update -y && sudo dnf upgrade -y
        break
        ;;
    debian)
        #Debian/Ubuntu-apt
        sudo apt-get update -y && sudo apt-get upgrade -y
        break
        ;;
    ubuntu)
        #Debian/Ubuntu-apt
        sudo apt-get update -y && sudo apt-get upgrade -y
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
    sudo snap refresh
fi

# Checks if Flatpak, How? searches for command named flatpak
if [ $(ls -al /sbin/ | grep "snap" | wc -l) != 0 ]; then
    #FlatPak
    sudo flatpak update 
fi