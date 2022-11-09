#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

startBox(){
    #   ARGSLIST
    #
    #   $1: BoxName -> Assume that $1 have it's existence checked
    #   $*: Command to run

    cp /etc/resolv.conf $BoxesPath/$1/etc/resolv.conf

    if [ "$Proot_DisableSECCOMP" == "true" ]; then
        prootexec="$InstallToPath/lib/proot-noseccomp"
    else
        prootexec="$InstallToPath/lib/proot"
    fi
    cd "$BoxesPath/$1"
    # echo $prootexec -r "$BoxesPath/$boxname" -b /proc -b /tmp -b /sys -b /dev ${boxshell} "$boxcmd"

    shift
    if [ "$1" != "" ]; then
        echo -ne "$@" > /tmp/start.prootbox.sh
    else
        echo -ne "/bin/bash" > /tmp/start.prootbox.sh
    fi

    if [ "$3" != "" ]; then
        runshit="runuser -l -c 'bash /tmp/start.prootbox.sh'"
    else
        runshit="bash /tmp/start.prootbox.sh"
    fi
    
    $prootexec $Proot_Arguments /bin/bash -c "unset \$http_proxy; unset\$https_proxy; bash /tmp/start.prootbox.sh"
}