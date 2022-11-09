#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

offlineInstall(){
    echo -ne "${boxInstall} Checking for directories..."
    if [ -d bin ] && [ -d lib ] && [ -d config ] && [ -f "main.sh" ]; then
        echo -ne " $sigok\n"
    else
        echo -ne " $sigfail\n${clred}Please run this again in ProotBox's main directory.${clend}"
    fi
}