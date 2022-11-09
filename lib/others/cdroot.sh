#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

cdIntoBoxRoot(){
    # ARGSLIST
    #
    #   $1: BoxName

    echo -ne "${barBox} Checking if box exists..."
    if [ ! -d $BoxesPath/$1 ]; then
        echo -ne " $sigfail\n\n"
        echo -ne "${sigfatal} Box $1 does not exist.\n"
        return
    fi

    echo -ne " $sigok\n\n"
    echo -ne "To exit your box's root, simply type ${clcyan}exit${clend} to cd back into your old directory.\n"

    $SHELL -c "cd '$BoxesPath/$1'; $SHELL"
}
