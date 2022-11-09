#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

getColorForOS(){
    # ArgsList{
    #   $1: OSName (/etc/release; caseid) ${caseSensitive}
    #
    #   $ReturnValue: ${method: Echo}, colorValue
    #}

    case $1 in
        ubuntu)
            colorRet="$clorange"
            ;;

        arch)
            colorRet="$clcyan"
            ;;

        rocky)
            colorRet="$clbrightgreen"
            ;;

        centos)
            colorRet="$clmag"
            ;;

        *)
            colorRet="$clend"
    esac
    
    echo -ne "${colorRet}"
}

cmdprint(){
    #
    # ARGSLIST
    # $1: Key
    # $2: Desc of key
    echo -ne "${clcyan}"
    printf "%-10s"
    printf "%-40s ${clend}${2}\n" "${1}"
}
cmdprint2(){

    echo -ne "$3"
    printf "%-10s"
    echo -ne "$4"
    printf "%-40s ${2}\n" "${1}"
}
printHelp(){
    echo -ne "${clmag}Syntax\n"
    cmdprint "<?argument>" "Optional argument"
    cmdprint "<argument>" "Required argument"
    echo

    echo -ne "${clmag}General Options${clend}\n"
    cmdprint "cli" "Start ProotBox in CLI mode."
    cmdprint "reinstall" "Reinstalls ${productName}."
    cmdprint "uninstall" "Uninstalls ${productName}."

    echo
    echo -ne "${clmag}Boxes${clend}\n"
    cmdprint "install/create <?boxname> <?imageURL>" "Install a box."
    cmdprint "delete/remove <boxname>" "Delete a box"
    cmdprint "start/enter <boxname>" "Start a box."
    cmdprint "cdroot <boxname>" "CD into a box's rootdir."
    cmdprint "ls <?--raw>" "List boxes. (Raw Data)"
    echo 
    cmdprint "lsimages" "List available Linux images."
    cmdprint "getimgurl <distroName> <distroVersion>" "Get image URL."
}


listboximages(){
    echo -ne "${clmag}Debian${clend}\n"
    cmdprint2 "OS" "Maintainer(s)" "${clgreen}" "${clgreen}"
    cmdprint "Debian" "Debian Maintainers"
    cmdprint "Ubuntu" "Canonical"
    cmdprint "Ubuntu-Server" "Canonical"

    # Redhat
    echo -ne "\n${clmag}Red Hat${clend}\n"
    cmdprint2 "OS" "Maintainer(s)" "${clgreen}" "${clgreen}"
    cmdprint "RockyLinux" "Rocky Enterprise Software Foundation"
    cmdprint "CentOS" "Red Hat Software"

    echo -ne "\n${clmag}Arch Linux${clend}\n"
    cmdprint2 "OS" "Maintainer(s)" "${clgreen}" "${clgreen}"
    cmdprint "ArchLinux" "Arch Linux team"
    # Others
    echo -ne "\n${clmag}Custom (Import from custom URL)${clend}\n"
    cmdprint "customlinux" "the owo maintainers"
}
