#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

installBox(){
    #   ARGSLIST
    #
    #   $1: BoxName
    #   $2: Image URL
    #   $3: --skip-postinstall<?>

    boxname="$1"
    imgurl="$2"

    mkdir -p $BoxesPath/.cache
    mkdir -p $BoxesPath/$boxname
    cd $BoxesPath/$boxname
    

    # Checking if image exists
    if [ "$(ls $BoxesPath/.cache | grep $(basename $imgurl))" == "$(basename $imgurl)" ]; then
        echo -ne "${barBox}${barBoxInstall} Image already exists in ${productName}'s cache. Installing from cached image..."
    else
        echo -ne "${barBox}${barBoxInstall} Downloading image... "
        curl -L "$imgurl" -o $BoxesPath/.cache/$(basename $imgurl) &>/tmp/imagedownload.prootbox.log
        if [ "$(ls $BoxesPath/.cache | grep $(basename $imgurl))" == "$(basename $imgurl)" ]; then
            echo -ne " $sigok\n"
        else
            echo -ne " $sigfail\n"
            echo "Failed to download the image. Here are the logs:"
            cat /tmp/imagedownload.prootbox.log
            return 1
        fi
        echo -ne "${barBox}${barBoxInstall} Installing from image..."
    fi

    tar -xvf $BoxesPath/.cache/$(basename $2) &>/dev/null

    # See if the image's rootfs is occupied in a dir
    if [ "$(ls | wc -l)" == "1" ]; then
      cd *
      mv * .. &>/dev/null
    fi
    echo -ne " $sigok\n"

    echo -ne "${boxBox}${barBoxInstall} Getting postInstallationScript path..."
    if [ "$3" == "--skip-postinstall" ]; then
        echo -ne " $sigskip\n"
    else
        if [ -f /tmp/postinstall.prootbox.conf ]; then
            echo

            # Export important variables
            export _pbox_postInstall_BoxRootDir="${BoxesPath}/${boxname}"

            startBox $boxname $(cat /tmp/postinstall.prootbox.conf)
        else
            echo -ne " $clgreen(none) $clcyan\nPost-installation-automated scripts should be saved in ${clgreen}/tmp/postinstall.prootbox.conf${clcyan}.${clend}\n"
        fi
    fi


    echo -ne "${barBox}${barBoxInstall} Doing some final touches...\n"
    rm -rf /tmp/postinstall.prootbox.conf 2>/dev/null

}