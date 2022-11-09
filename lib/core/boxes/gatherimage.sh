#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

getInstallerLink(){
    #   ARGSLIST
    #   
    #   $1: os name
    #   $2: os version
    #
    #   returnValue -> download link

    echo -ne "${barBox}${clcyan}[ImageUtils]${clend} Getting ${1}'s image URL..." >&2

    case $1 in
        "Ubuntu-Server"|"Ubuntu")
            if [ "${2}" == "" ]; then
                version="22.04"
            else
                version="$2"
            fi
            imageurl="http://cdimage.ubuntu.com/ubuntu-base/releases/${version}/release/ubuntu-base-${version}-base-amd64.tar.gz"
            if [ "$1" == "Ubuntu-Server" ]; then
                postInstallFile="$InstallToPath/lib/postinstall/debian-postinstall \"base coreutils ubuntu-server\""
            else
                postInstallFile="$InstallToPath/lib/postinstall/debian-postinstall \"base coreutils ubuntu-minimal\""
            fi
            ;;

        "ArchLinux")
            imageurl="https://geo.mirror.pkgbuild.com/iso/2022.11.01/archlinux-bootstrap-x86_64.tar.gz"
            postInstallFile="$InstallToPath/lib/postinstall/arch-postinstall"
            ;;

        "CentOS")
            if [ "$2" == "" ]; then
                version="7"
            else
                version="$2"
            fi
            imageurl="https://download.openvz.org/template/precreated/centos-${version}-x86_64-minimal.tar.gz"
            postInstallFile="exit"
            ;;

        "RockyLinux")
            if [ "$2" == "" ]; then
                version="8.5"
            else
                version="$2"
            fi
            imageurl="https://github.com/rocky-linux/sig-cloud-instance-images/raw/Rocky-${version}-x86_64/rocky-${version}-docker-x86_64.tar.xz"
            postInstallFile="exit"
            ;;

        "customlinux")
            imageurl="${2}"
            ;;

        
        *)
            echo -ne " $sigfail\n" >&2
            echo -ne "$1 Linux does not exist in ProotBox's image database.\n"
            return
    esac
    echo -ne " $sigok\n" >&2

    echo -ne "${barBox}${clcyan}[ImageUtils]${clend} Checking if ${1}'s image URL exists..." >&2
    urlStatusCode=$(curl -I "$imageurl" 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    echo -ne " $sigok\n" >&2
    if [ "$urlStatusCode" !=  "200" ] && [ "$urlStatusCode" != "302" ]; then
        echo -ne " $sigfail ${clred}($urlStatusCode)${clend}\n\n" >&2
        echo -ne "Please enter a valid version of ${clred}${1}${clend} to download.\n" >&2
        return
    fi
    echo -ne "$imageurl"
    echo -ne "$postInstallFile" > /tmp/postinstall.prootbox.conf
}
