runChecks(){

    echo -ne "${barBox}${chkInstaller} Welcome to ${productName} installer! Before the installation process starts, I'll need to check your system first.\n"
    echo -ne "${barBox}${chkInstaller} If you want to cancel the installation, press CTRL+C.\n\n"
    echo -ne "${barBox}${chkInstaller} Waiting for 5 seconds for confirmation...\n"
    sleep 3
    echo -ne "\n${barBox}${chkInstaller} Starting system checking process...\n"
    sleep 2

    # Kernel version checking
    
    echo -ne "${barBox}${chkInstaller}${chkCheck} Checking kernel name... "
    if [ "$(uname)" != "Linux" ]; then
        echo -ne "${sigfail}\nYour system is not running the Linux kernel, as we only supports installing on the Linux kernel.\n"
        echo -ne "Thanks for understanding!\n"
        exit 1
    fi
    echo -ne "$sigok\n"

    # Architecture checking

    echo -ne "${barBox}${chkInstaller}${chkCheck} Checking System Architecture... "
    if [ "$SkipArchitectureCheck" != "true" ]; then
        if [ "$(uname -m)" != "x86_64" ]; then
            echo -ne " ${sigfail}\n\nYour system's architecture is $(uname -m), but we only support x86_64 at the moment.\n"
            echo -ne "Thank you for understanding!\n"
            exit
        fi
        echo -ne "$sigok\n"
    else
        echo -ne "$sigskip\n"
    fi

    echo -ne "${barBox}${chkInstaller}${chkCheck} Checking for required binaries... "
    if [ "$SkipPackageCheck" != "true" ]; then

        for pkg in $PackageRequirements; do
            echo -ne "\r${barBox}${chkInstaller}${chkCheck} Checking for required binaries... (${pkg}) "

            if [ ! -f "/usr/bin/$pkg" ]; then
                echo -ne "$sigfail"
                echo -ne "\n\nYour system does not have the '$pkg' binary, which ProotBox depends on to function.\n"
                echo -ne "Please install that binary for it to function :)"
                exit
            fi
        done

        echo -ne "\r${barBox}${chkInstaller}${chkCheck} Checking for required binaries... Completed ($sigok)\n"

    else
        echo -ne "$sigskip\n"
    fi

    # Existing installation checking

    echo -ne "${barBox}${chkInstaller}${chkCheck} Checking for an existing installation... "
    if [ -d "$InstallToPath" ]; then
        if [ "$ForceInstallationOverwrite" != "true" ]; then
            echo -ne "$sigfail\n\n"
            echo -ne "You can set the environment variable ${clmag}ProotBox_ForceInstallationOverwrite${clend} to ${clgreen}true${clend} to overwrite the installation."
            echo -ne "\n${clred}WARNING: All data in the installation directory will be lost!\n${clend}"
            exit 1
        fi
        rm -rf $InstallToPath
        echo -ne "$sigskip\n"
    else
        echo -ne "$sigok\n"
    fi
    mkdir -p $InstallToPath

    



    echo -ne "${barBox}${chkInstaller}${chkCheck} The checking procedure has completed.\n"
}

deploy(){
    echo -ne "\n\n${barBox}${chkInstaller} Starting deployment process..."

    cd $InstallToPath
    echo -ne "\n${barBox}${chkInstaller}${chkDeploy} Creating root... "

    # Root creation
    mkdir bin
    mkdir lib
    mkdir lib/postinstall
    mkdir docs

    mkdir -p $BoxesPath/.cache

    echo -ne "$sigok\n"


    echo -ne "${barBox}${chkInstaller}${chkDeploy} Extracting proot..."
    cd lib
    echo -ne "$proot_tarGz" | base64 -d > proot.tar.gz; tar -xvf proot.tar.gz >/dev/null; rm -rf proot.tar.gz
    cd ..
    echo -ne " $sigok\n"
    

    echo -ne "${barBox}${chkInstaller}${chkDeploy} Extracting sudo (fakeroot, fakechroot) script into ./lib..."
    cat > ./lib/postinstall/sudo << EOF
#!/bin/bash
for opt in "\$@"
do
    case "\$1" in
        --) shift ; break ;;
        -*) shift ;;
        *) break ;;
    esac
done

export FAKEROOTDONTTRYCHOWN=true
if [[ -n "\${@}" ]]
then
  if [[ \$FAKECHROOT == true ]]
  then
      fakechrootcmd=""
  else
      fakechrootcmd="fakechroot"
  fi

  if [[ -n \$FAKED_MODE ]]
  then
      fakerootcmd=""
  else
      fakerootcmd="fakeroot"
  fi

  \$fakechrootcmd \$fakerootcmd "\${@}"
fi

EOF
    chmod +x ./lib/postinstall/sudo
    echo -ne " $sigok\n"

    # Debian Post-Install
    echo -ne "${barBox}${chkInstaller}${chkDeploy} Extracting Debian (and Debian-bases OSes) Post-Installation script..."
    cat > ./lib/postinstall/debian-postinstall << EOF
#!/bin/bash

INSTALLID="\${RANDOM}\${RANDOM}"
# Install function
installPackages(){
    # \$1: Packages to install
    pkgcount=0
    for pkg in \$1; do pkgcount="\$((\$pkgcount+1))"; done
    onwatpkg=1
    for pkg in \$1; do
        printf "\r%50s"
        echo -ne "\r${barBox}${barBoxInstall}${barPostInstall} Installing base packages... (\$onwatpkg/\$pkgcount - \$pkg)"
        yes 'y' | DEBIAN_FRONTEND=noninteractive apt install \$pkg -y --allow-unauthenticated &>/tmp/\${pkg}.debian.postinstall.\${INSTALLID}.pbox.log
        onwatpkg=\$((\$onwatpkg+1))
    done
    echo -ne " $sigok\n"
    echo -ne "${barBox}${barBoxInstall}${barPostInstall} Upgrading packages..."
    yes 'y' | DEBIAN_FRONTEND=noninteractive apt upgrade -y &>/tmp/debian.upgrade.pbox.log
    echo -ne " $sigok\n"
}
echo -ne "${barBox}${barBoxInstall} Starting Debian Post-Install script... (install-id: \${INSTALLID})\n"

echo -ne "${barBox}${barBoxInstall}${barPostInstall} Configuring APT..."
touch /etc/apt/apt.conf.d/420-prootbox
echo "Acquire::AllowInsecureRepositories \"true\";" >> /etc/apt/apt.conf.d/420-prootbox
echo "Acquire::AllowDowngradeToInsecureRepositories \"true\";" >> /etc/apt/apt.conf.d/420-prootbox
echo -ne " $sigok\n"

echo -ne "${barBox}${barBoxInstall}${barPostInstall} Updating APT Packages..."
apt update -y &>/dev/null
echo -ne " $sigok\n"

installPackages "curl wget git \$1"
echo -ne "${barBox}${barBoxInstall} Post-Installation completed.\n"
echo "completed" > /etc/postconfig.status
exit
EOF
    chmod +x ./lib/postinstall/debian-postinstall
    echo -ne " $sigok\n"

  
    echo -ne "${barBox}${chkInstaller}${chkDeploy} Extracting Arch Linux (and Arch-bases OSes) Post-Installation script..."
cat > ./lib/postinstall/arch-postinstall << EOF
#!/bin/bash
# In order for pacman and makepkg to work, we need to change some essential stuff in config files for those
# applications to function
INSTALLID="\${RANDOM}\${RANDOM}"; mkdir /tmp/prootbox-postinstall-\${INSTALLID}
RootDirectory="\${_pbox_postInstall_BoxRootDir}"

#########
echo "The Arch Post-Installation is broken as of now."
echo "Please consider configuring it manually, as we're exiting now."
exit
#########

# Install function
installPackages(){
    # \$1: Packages to install
    pkgcount=0
    for pkg in \$1; do pkgcount="\$((\$pkgcount+1))"; done
    onwatpkg=1

    for pkg in \$1; do
        printf "\r%50s"
        echo -ne "\r${barBox}${barBoxInstall}${barPostInstall} Installing base packages... (\$onwatpkg/\$pkgcount - \$pkg)"
        pacman -S \${pkg} --noconfirm &>/tmp/prootbox-postinstall-\${INSTALLID}/\${pkg}.pacman.log
        onwatpkg=\$((\$onwatpkg+1))
    done
    echo -ne " $sigok\n"
}
echo -ne "${barBox}${barBoxInstall} Starting Arch Post-Install script... (install-id: \${INSTALLID})\n"

echo -ne "${barBox}${barBoxInstall}${barPostInstall} Configuring ${clcyan}pacman${clend}..."
curl -L "https://raw.githubusercontent.com/ambientxd/RootlessArch/main/patches/mirrorlist" -o /etc/pacman.d/mirrorlist &>/dev/null
sed -i "s+#RootDir     = /+RootDir     = \$RootDirectory+g" \$RootDirectory/etc/pacman.conf
echo -ne " $sigok\n"

echo -ne "${barBox}${barBoxInstall}${barPostInstall} Dealing with pacman keys..."
pacman-key --init &>/tmp/prootbox-postinstall-\${INSTALLID}/pacman-key.init.log
pacman-key --populate archlinux &>/tmp/prootbox-postinstall-\${INSTALLID}/pacman-key.populate.log
pacman -Syy &>/tmp/prootbox-postinstall-\${INSTALLID}/update-mirrorlists.pacman.log

installPackages "base-devel git curl wget tar \$1"
echo -ne "${barBox}${barBoxInstall} Post-Installation completed.\n"
echo "completed" > /etc/postconfig.status
exit
EOF
    echo -ne " $sigok\n"

    echo -ne "\n${barBox}${chkInstaller} Installation finished. No errors found :)\n"
    chmod +x ./lib/postinstall/arch-postinstall
}