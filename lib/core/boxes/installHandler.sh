#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

installboxHandler(){
    # argslist
    # $1: Box Name
    # $2: Box URL

    if [ "$2" == "" ]; then
        echo -ne "${barBox} No extra arguments found, going for CLI installer...\n"
        installboxCLIHandler
        return
    fi
    shift

    echo -ne "${barBox} Checking for arguments..."
    if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo -ne " $sigfail (Missing arguments)\n"
        exit
    fi
    echo -ne " $sigok\n"

    urlStatusCode=$(curl -I "$2" 2>/dev/null | head -n 1 | cut -d$' ' -f2)
    if [ "$urlStatusCode" !=  "200" ] && [ "$urlStatusCode" !=  "302" ]; then
        echo -ne " $sigfail (Invalid Box URL)\n"
        exit
    fi

    echo -ne "${barBox} Creating box..."
    if [ -d $BoxesPath/"$1" ]; then
        echo -ne " $sigfail (Box already exists)\n"
        exit
    fi
    echo -ne " $sigok\n"

    echo -ne "${barBox} Passing arguments into installer...\n"
    installBox "$1" "$2" "$3"
    
}

installboxCLIHandler(){
    echo -ne "${barBox} Starting CLI installer...\n\n"
    echo -ne "${barBox}${barBoxInstall} Hello, welcome to the CLI box installation.\n"
    echo -ne "${barBox}${barBoxInstall} First of all, please enter your box's name.\n"
    
    echo -ne "${barBoxInstall} ${clyellow}Box name>${clend} "; read boxname
    cboxname="${clcyan}${boxname}${clend}"
    echo -ne "\n${barBox}${barBoxInstall} Got it, so your box's name is ${cboxname}."
    echo -ne "\n${barBox}${barBoxInstall} Please wait, creating box ${cboxname}'s root..."
    
    if [ -d $BoxesPath/$boxname ]; then
        echo -ne " $sigfail"
        echo -ne "\n\n${barBox}${barBoxInstall} ${cboxname} exists in ${clred}\$BoxesPath${clend}."
        echo -ne "\n${barBox}${barBoxInstall} You need to run ${clmag}delete ${cboxname} to delete the conflicting box."
        return
    fi

    echo -ne "\n\n${barBox}${barBoxInstall} Please select an image to download...\n(Case Sensitive) Format: <Image Name> <Image Version>\nExample: Ubuntu 22.04, Ubuntu latest\n"
    listboximages
    while [ true ]; do
        echo -ne "${barBoxInstall}${clyellow} Image> ${clend}"; read imglink
        installerLink=$(getInstallerLink $imglink)
        if [ "$installerLink" == "" ]; then
            echo -ne "${clred}Image doesn't exist.${clend}\n"
        else   
            break
        fi
    done
    installBox "$boxname" "$installerLink" "$(cat /tmp/postinstall.prootbox.conf)"
}
