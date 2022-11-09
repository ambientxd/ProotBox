#!/bin/bash
# ____                  _   ____            
#|  _ \ _ __ ___   ___ | |_| __ )  _____  __
#| |_) | '__/ _ \ / _ \| __|  _ \ / _ \ \/ /
#|  __/| | | (_) | (_) | |_| |_) | (_) >  < 
#|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\
#
# Licensed under GNU General Public License v3.0.

### Configuration for Prootbox Installer ###
ProotBox_UseColor=true
InstallToPath="/tmp/prootbox"
BoxesPath="$HOME/.local/share/prootboxes"

ForceInstallationOverwrite="false" # false, true
SkipArchitectureCheck="false" # false, true

SkipPackageCheck="false" # false, true
PackageRequirements="git curl head cut basename awk printf" # Binaries in /usr/bin or anything in $PATH.

# Product
productName="ProotBox"
productVersion="0.1"
productLicense="GNU General Public License v3.0"
productAuthor="ambient"
productGitURL="http://localhost:5500"

# Colors handling
### Colors
if [ "$ProotBox_UseColor" != "false" ]; then
    source "$InstallToPath/config/colors.sh"
fi

# Signals
sigok="${clgreen}ok${clend}"
sigfail="${clred}fail${clend}"
sigskip="${clyellow}skipped${clend}"

sigfatal="${clred}[Fatal]${clend}"

# Bars
chkInstaller="${clmag}[Installer]${clend}"
chkCheck="${clcyan}[System Check]${clend}"
chkDeploy="${clyellow}[Deployment]${clend}"

barBox="${clorange}[${productName}]${clend}"
barBoxInstall="${clcyan}[Box Installation]${clend}"
barPostInstall="${clyellow}[PostInstall]${clend}"

# Sourcing the files
source "$InstallToPath/lib/core/boxes/gatherimage.sh"
source "$InstallToPath/lib/core/boxes/install.sh"
source "$InstallToPath/lib/core/boxes/installHandler.sh"
source "$InstallToPath/lib/core/boxes/startbox.sh"

source "$InstallToPath/lib/core/installer/checks.sh"

source "$InstallToPath/lib/others/cdroot.sh"
source "$InstallToPath/lib/others/cli.sh"
source "$InstallToPath/lib/others/frontend.sh"

# Config sources
source "$InstallToPath/config/boxes.sh"




_pbox_easteregg_rickroll(){
echo -ne "$bgblack"
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⣀⣈⣒⣤⣤⠤⠤⢤⣀⣀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡠⠀⠀⡔⣿⣿⣿⣿⣿⣿⣿⣦⣄⠈⠑⠒⠀⠂⠀⠀⠀⠀⠈⠒⠒⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⡅⠹⡄⢀⢤⡼⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⡦⠴⣶⠲⠀⠀⠀⢀⡤⡄⠀⠒⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠂⠑⠒⠒⠓⠃⠘⢾⣿⣾⡇⠀⠀⠉⠁⠈⠉⢻⣿⡇⠠⠄⠤⣀⠀⠀⠀⠻⢅⣀⣈⣒⠀⠀⠀⠀⠀⠀⠀⠲⡄⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠃⢠⠴⠦⠦⢦⣘⢻⣿⣷⣦⣤⠠⣄⣀⡀⢸⣿⣧⡀⠀⠸⣻⡇⠀⠠⣦⡀⠉⠙⢤⣀⣀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⠀⠀⠀⠀⠀⡠⠒⡇⠂⢲⠒⠒⣼⣮⣿⠉⠉⠙⠀⠻⠛⠛⢺⡏⠬⡭⣵⣀⠈⠁⠀⠀⡿⣟⣆⠀⠀⠀⠀⠣⣄⡀⠀⠢⡀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠞⣀⠢⠀⠀⠀⠀⢑⡤⠄⠠⠬⢏⣉⣹⣿⡗⠀⠀⡿⡒⠀⠀⠀⢿⡗⠒⠒⢺⠊⡵⠀⠀⠀⡿⣭⠏⡄⠀⠁⢀⠀⠀⠓⢤⡀⠈⡆⠀⡀⠀
echo ⠀⠀⠄⠀⠀⢹⠀⠀⠀⠀⢀⡰⠛⠷⡀⠀⠀⠀⢗⠒⠒⠒⠚⠂⠤⠼⢤⣧⡈⠙⠯⠽⠲⠀⡖⠻⠀⢀⣉⣹⣉⣧⠀⠀⠀⠉⣵⢆⠑⢆⠀⢀⡨⠆⣀⣀⠀⠉⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠉⠈⠁⠢⢄⠏⠀⠒⠒⡇⠀⠀⠴⡈⠑⣎⣀⣁⣀⡴⠊⢁⡟⠷⢄⡀⠀⠤⢣⣤⡐⠒⠒⠦⢼⠖⠋⡀⠀⠀⣶⣟⣊⣢⡈⠒⣁⠀⢸⣿⡿⠁⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣸⠀⠀⠀⠀⠇⠀⠀⢀⡨⠆⠈⠉⠒⠚⢠⣤⢿⣇⠀⠀⠀⠀⢀⠞⣿⣿⣟⣤⣖⣊⠠⠞⠃⠀⠀⢻⠤⡧⠤⢣⣊⠁⠁⡀⠉⣀⠄⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⡠⠀⠈⣏⣹⠤⣆⡤⠀⠀⠀⠀⠀⠈⢀⡔⣫⠭⢹⣿⢯⡿⣾⣿⣤⡄⣀⠴⠋⢠⣿⣿⣿⣷⣦⣭⣭⣖⣺⣶⣤⡄⠒⠓⢺⠈⠠⣀⢠⠟⠀⠋⠁⠀⠒⠂⠀⠀
echo ⠀⠀⠀⢰⠀⠀⠠⡈⣬⢵⠟⣘⠲⠶⠀⠀⠀⣴⠟⣉⣴⣾⣿⣿⣸⢷⢸⠁⠹⡟⠃⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⢀⡿⣈⠲⣤⠏⡴⠦⡀⡖⠒⠲⠄⠀⠀
echo ⠀⠀⠀⠠⠤⠂⠊⠁⠈⠉⣎⣈⠵⢄⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣇⣟⣓⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⢠⠑⠇⠏⢴⡱⠒⣇⠘⢄⠀⠀⠀⠀
echo ⠀⠂⠀⣠⠂⠀⠀⠀⠀⠸⡀⢰⡀⢸⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣿⣒⡺⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠆⠀⠧⠀⠀⠀⠉⠑⠛⠀⢧⠀⠀⠀⠀
echo ⢀⠤⠾⠷⣀⣀⠇⡴⣆⠀⠳⡀⠀⢹⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣀⡿⠶⠭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⢀⠀⣟⠯⢦⡀⠈⠓⢤⡀⠀
echo ⡎⠓⠒⠂⠤⡞⢠⠓⠺⡀⠀⢧⠀⡘⠀⠀⠰⣿⣿⣿⣿⣿⣿⣿⣿⣿⡾⣍⡯⠭⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠈⣆⠳⢬⠒⠚⠒⡄⠀⠀⠀
echo ⠘⠢⡀⠒⢒⠁⡎⢀⡰⠃⠤⡈⡤⢿⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⢭⣿⣟⣓⣿⣿⣿⣿⣿⣏⠩⠉⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣘⠈⠀⢇⣩⣉⣹⠂⠀⠀
echo ⢀⠐⢍⠁⠘⢰⢉⡽⢀⡀⢍⢳⠸⡷⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣿⣒⣾⣿⣿⣿⣿⣿⠷⡀⠂⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠈⢉⢀⣖⠁⠀⡆⠀
echo ⠈⠱⠀⠀⠀⠛⠉⡴⠛⠘⠢⡉⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⠭⢽⣿⣿⣿⣿⣿⣿⣭⣤⡄⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣀⠔⢋⡤⡄⠐⠂
echo ⠀⠀⠀⠀⠀⡠⠚⠀⠀⠩⡍⠓⣄⠀⠀⠀⢸⣿⣿⣿⣿⠿⠿⠛⣛⣻⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢀⡧⠀⠈⢢⠀
echo ⠀⠀⢰⠀⠀⢏⠉⠉⠉⠀⠉⠱⡼⠀⠀⠀⠰⣿⣿⣯⣤⡎⠭⠤⠜⣿⣿⣿⣓⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢥⠀⠰⣿⣄⣀⠀⠀⠀
echo ⠀⠀⠸⠀⠀⡀⠉⡀⠀⠀⡰⠉⠀⠀⠀⠀⠀⠸⣿⣿⣿⡃⠒⣒⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⡇⠀⠉⠉⠡⠄⠀⠀⠠⠜⠀⠀⠇⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⢰⢙⣄⠉⠢⠊⢀⡖⢆⠀⠀⠀⠐⠢⡌⠛⢿⣷⣤⣴⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠸⠀⠈⢳⠀⠔⠉⠀⣸⠀⠀⠀⠀⠀⠙⢢⠀⠌⣽⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo ⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⣀⠌⠀⢠⢿⣿⣿⡇⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
echo -ne "${clcyan}Never gonna give you up\n"
sleep 2
echo -ne "${clyellow}Never gonna let you down\n"
sleep 2
echo -ne "${clcyan}Never gonna roll around and desert you\n"
sleep 2
echo -ne "${clyellow}Never make you cry\n"
sleep 2
echo -ne "${clcyan}Never gonna say goodbye\n"
sleep 2
echo -ne "${clyellow}Never gonna tell a lie\n"
sleep 2
echo -ne "${clcyan}And hurt you\n${clend}"
}

_pbox_info_prootTeam(){
    echo -ne "${clyellow}PRoot${clend} (https://proot-me.github.io/)\n\n"
    echo -ne "${clcyan}PRoot${clend} is a ${clgreen}user-space implementation${clend} of chroot, mount --bind, and binfmt_misc. \nThis means that ${clgreen}users don't need any privileges or setup${clend} to do things like "
    echo -ne "\nusing an arbitrary directory as the new root filesystem, making files \n"
    echo -ne "${clmag}accessible${clend} somewhere else in ${clgreen}the filesystem hierarchy${clend}, or ${clmag}executing programs${clend} \nbuilt for ${clgreen}another CPU architecture transparently${clend} through ${clmag}QEMU user-mode${clend}. \n\n"

    echo -ne "Also, developers can use ${clyellow}PRoot${clend} as a ${clgreen}generic Linux process instrumentation engine${clend} \nthanks to its ${clmag}extension mechanism${clend}, see ${clcyan}CARE${clend} for an example. Technically ${clyellow}PRoot${clend} \n"
    echo -ne "relies on ${clmag}ptrace${clend}, ${clgreen}an unprivileged system-call available in every Linux kernel.${clend}\n\n"

    echo -ne "The source code for ${clyellow}PRoot${clend} and ${clcyan}CARE${clend} are hosted \nin the ${clmag}same repository${clend} on ${clyellow}https://github.com/proot-me/proot${clend}.\n"
}   


_pbox_info_db(){
    case $@ in
        "David Hoang")
            _pbox_easteregg_rickroll
            ;;

        "PRoot Team"|proot)
            _pbox_info_prootTeam
            ;;
        
        *)
            echo "hmmm... i dont think that i can see someone with the name '$@' in the contributors list"; echo
            exit
            ;;
    esac
    echo
}
_pbox_Info(){
echo -ne "${clorange}\n"
echo ' ____                  _   ____            '
echo '|  _ \ _ __ ___   ___ | |_| __ )  _____  __'
echo '| |_) | `__/ _ \ / _ \| __|  _ \ / _ \ \/ /'
echo '|  __/| | | (_) | (_) | |_| |_) | (_) >  < '
echo '|_|   |_|  \___/ \___/ \__|____/ \___/_/\_\'
echo -ne "                                     ${clgreen}v${productVersion}${clend}\n"
echo -ne "Made by ${clcyan}${productAuthor}${clend}, licensed under ${clyellow}${productLicense}${clend}.\n"
echo

shift
if [ "$1" == "info" ]; then
    shift
    _pbox_info_db $@
    exit
fi

echo -ne "${clmag}Special thanks to:${clend}\n"
cmdprint "PRoot Team" "Providing the main binary to execute the program."
cmdprint "me" "yes, me"

echo -ne "\n${clmag}Beta Testers:${clend}\n"
cmdprint "David Hoang" "Thanks for the ASCII logo :)"

echo
echo -ne "Use the command ${clgreen}version info ${clorange}<name/team name>${clend} to get the contributor's info!\n"
}


if [ -d "$InstallToPath" ]; then

    case $1 in
        # Cli Options
        reinstall)
            export ForceInstallationOverwrite=true
            runChecks
            deploy
            exit
            ;;

        uninstall)
            echo -ne "${barBox}${chkInstaller} Removing $InstallToPath... "
            rm -rf $InstallToPath
            echo -ne "$sigok\n"
            echo -ne "${barBox}${chkInstaller} Uninstallation completed. ;(\n"
            exit
            ;;


        # Boxes
        install|create)
            installboxHandler $@
            exit
            ;;

        lsimages)
            listboximages
            exit
            ;;
        getimgurl)
            shift
            getInstallerLink $@
            echo -ne "\n" >&2
            exit
            ;;

        start|enter)
            shift
            startBox $@
            exit
            ;;
        cdroot)
            shift
            cdIntoBoxRoot $@
            exit
            ;;
        ls)
            if [ "$(ls $BoxesPath)" == "" ]; then
                echo -ne "${sigfatal} Please install a box before running this command.\n" >&2
                exit
            fi

            if [ "$2" == "--raw" ]; then
                ls $BoxesPath --color=no
                exit
            else
                cmdprint2 "$(echo -ne '\r')Box Name" "Installed OS" "$clgreen" "$clgreen"
                for img in $(ls $BoxesPath); do
                    osid=$(bash -c "source $BoxesPath/$img/etc/os-release; echo \$ID" 2>/dev/null)
                    oscolor=$(getColorForOS $osid)

                    osname=$(bash -c "source $BoxesPath/$img/etc/os-release; echo \$NAME" 2>/dev/null)
                    if [ -f $BoxesPath/$img/etc/os-extra-info ]; then
                        osname="$osname $(cat $BoxesPath/$img/etc/os-extra-info)"
                    fi
                    
                    if [ "$osname" == "" ]; then
                        osname="unknown (/etc/os-release not found)"
                    fi

                    osver=$(bash -c "source $BoxesPath/$img/etc/os-release; echo \$VERSION" 2>/dev/null)
                    cmdprint2 "$(echo -ne '\r')$img" "${oscolor}$osname $osver" "$clcyan"
                done
                echo -ne "${clend}"
            fi
            exit
            ;;
        
        info)
            boxname=$2
            if [ "${boxname}" == "" ]; then
                echo -ne "${sigfatal} Arguments not found: boxname\n"
                echo -ne "${clend}USAGE: ${clcyan}boxinfo ${clmag}<boxname: Box must exist>${clend}\n"
                exit
            fi
            if [ ! -d "$BoxesPath/${boxname}" ]; then
                echo -ne "${sigfatal} No box named \"${boxname}\" found."
                echo -ne "\n${clend}USAGE: ${clcyan}boxinfo ${clmag}<boxname: Box must exist>${clend}\n"
                exit
            fi

            echo -ne "${clmag}Box ${clgreen}${boxname}${clmag}'s information:\n"
            # date n time shit
            cmdprint "Creation Date" "$(stat -c '%w' ${BoxesPath}/${boxname})"
            cmdprint "Last Accessed" "$(stat -c '%y' ${BoxesPath}/${boxname})"
            echo

            if [ -f $BoxesPath/$boxname/etc/os-release ]; then
                osname=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$NAME")
                if [ -f $BoxesPath/$boxname/etc/os-extra-info ]; then
                    osname="$osname $(cat $BoxesPath/$boxname/etc/os-extra-info)"
                fi

                osver=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$VERSION")
                oshomepage=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$HOME_URL")
                osbugreport=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$BUG_REPORT_URL")
                ossupporturl=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$SUPPORT_URL")
                osid=$(bash -c "source $BoxesPath/$boxname/etc/os-release; echo \$ID")
                oscolor=$(getColorForOS $osid)
            

                cmdprint "OS" "${oscolor}$osname $osver"
                cmdprint "Homepage URL" "${oscolor}$oshomepage"
                cmdprint "Support URL" "${oscolor}$ossupporturl"
                cmdprint "Bug report URL" "${oscolor}$osbugreport"
            else
                cmdprint "OS" "unknown (/etc/os-release not found)"
            fi

            echo
            cmdprint "Root Path" "${BoxesPath}/${boxname}"
            cmdprint "Box Size" $(du -sh $BoxesPath/$boxname 2>/dev/null | head -n1 | awk '{print $1;}')

            
            


            echo; exit
            ;;

        delete|remove)
            if [ "$2" == "" ]; then echo -ne "${clgreen}USAGE:${clmag} delete ${clcyan}<boxname>${clend}\n"; exit; fi
            echo -ne "${barBox} Getting ready..."
            if [ ! -d ${BoxesPath}/$2 ]; then
                echo -ne " $sigfail (Box ${clcyan}$2${clend} not found)\n"
                exit
            fi
            echo -ne " $sigok\n"
            kill -9 $(pgrep proot) &>/dev/null
            sleep 1
            echo -ne "${barBox} Deleting box..."
            rm -rf $BoxesPath/$2 &>/dev/null
            echo -ne " $sigok\n"
            exit
            ;;

        cleancache)
            echo -ne "${barBox} Cleaning cache..."
            rm -rf $BoxesPath/.cache/* &>/dev/null
            echo -ne " $sigok\n"
            exit
            ;;

        cli)
            _pbox_prootboxcli
            exit
            ;;

        version)
            _pbox_Info $@
            exit
            ;;


        -*|--*|-h|--help|h|help)
            printHelp
            exit
            ;;
    esac
    printHelp


else

    if [ -f "./lib/core/installer/offlineInstall.sh" ]; then
        source "./lib/core/installer/offlineInstall.sh"
        runChecks
        offlineInstall
    else
        echo -ne "Cloning $productGitURL...\n"
        oldDir="$PWD"
        cd /tmp
        git clone $productGitURL prootbox_github
        cd prootbot_github
        bash main.sh
        cd $oldDir
    fi
fi