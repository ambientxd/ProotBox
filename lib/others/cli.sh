#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

_pbox_prootboxcli(){
    echo -ne "${clcyan}${productName} ${clred}v${productVersion}${clend} CLI\n" >&2
    echo -ne "Licensed under ${clyellow}${productLicense}${clend} license.\n" >&2
    echo -ne "Running on ${clcyan}$(uname -a)${clend}\n\n"

    while true; do
        echo -ne "${clcyan}>>> ${clend}"; read tempinput
        if [ "$tempinput" == "exit" ]; then
            exit
        fi
        echo
        bash $0 $tempinput
        echo
    done
}