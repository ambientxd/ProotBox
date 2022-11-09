#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

INSTALLID="${RANDOM}${RANDOM}"
# Install function
installPackages(){
    # $1: Packages to install
    pkgcount=0
    for pkg in $1; do pkgcount="$(($pkgcount+1))"; done
    onwatpkg=1
    for pkg in $1; do
        printf "\r%50s"
        echo -ne "\r\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m\e[33m[PostInstall]\e[0m Installing base packages... ($onwatpkg/$pkgcount - $pkg)"
        yes 'y' | DEBIAN_FRONTEND=noninteractive apt install $pkg -y --allow-unauthenticated &>/tmp/${pkg}.debian.postinstall.${INSTALLID}.pbox.log
        onwatpkg=$(($onwatpkg+1))
    done
    echo -ne " \e[32mok\e[0m\n"
    echo -ne "\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m\e[33m[PostInstall]\e[0m Upgrading packages..."
    yes 'y' | DEBIAN_FRONTEND=noninteractive apt upgrade -y &>/tmp/debian.upgrade.pbox.log
    echo -ne " \e[32mok\e[0m\n"
}
echo -ne "\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m Starting Debian Post-Install script... (install-id: ${INSTALLID})\n"

echo -ne "\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m\e[33m[PostInstall]\e[0m Configuring APT..."
touch /etc/apt/apt.conf.d/420-prootbox
echo "Acquire::AllowInsecureRepositories \"true\";" >> /etc/apt/apt.conf.d/420-prootbox
echo "Acquire::AllowDowngradeToInsecureRepositories \"true\";" >> /etc/apt/apt.conf.d/420-prootbox
echo -ne " \e[32mok\e[0m\n"

echo -ne "\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m\e[33m[PostInstall]\e[0m Updating APT Packages..."
apt update -y &>/dev/null
echo -ne " \e[32mok\e[0m\n"

installPackages "curl wget git $1"
echo -ne "\e[38;5;208m[ProotBox]\e[0m\e[36m[Box Installation]\e[0m Post-Installation completed.\n"
echo "completed" > /etc/postconfig.status
exit