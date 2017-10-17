#!/bin/sh

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;36m"
NORMAL="\033[0m"

WHOAMI=`whoami`
datetime=$(date +%Y%m%d%H%M%S)
HOSTNAME=`hostname`

VUNDLE_HTTPS="https://github.com/VundleVim/Vundle.vim.git"
TPM_HTTPS="https://github.com/tmux-plugins/tpm.git"

lowercase(){
	echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

get_ip(){
	INTERFACE=`ip addr | grep "state UP" | awk -F " " '{ print $2 }' | awk -F ":" '{ print $1 }'`
	IPADDR=`ip addr show ${INTERFACE} | grep inet | grep -v inet6 | awk -F " " '{ print $2 }' | awk -F "/" '{ print $1 }'`
}

os_check(){
	OS=`uname`
	KERNEL=`uname -r`
	MACH=`uname -m`

	if [ "${OS}" = "Linux" ] ; then
		if [ -f /etc/redhat-release ] ; then
			DistroBasedOn='RedHat'
			DIST=`cat /etc/redhat-release |sed s/\ release.*//`
			PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
			REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
		elif [ -f /etc/debian_version ] ; then
			DistroBasedOn='Debian'
			if [ -f /etc/lsb-release ] ; then
				DIST=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
				PSUEDONAME=`cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }'`
				REV=`cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }'`
			fi
		fi
		readonly OS
		readonly DIST
		readonly DistroBasedOn
		readonly PSUEDONAME
		readonly REV
		readonly KERNEL
		readonly MACH
	fi
}

perm_check(){
	if [ $WHOAMI = "root" ];then
		SUDO=
	else
		SUDO=sudo
	fi
}

conf_backup(){
	if [ $WHOAMI = "root" ]; then
		CONF_BAK="/root/conf_bak-${datetime}"
	else
		CONF_BAK="/home/$WHOAMI/conf_bak-${datetime}"
	fi
	echo "create backup directory ${CONF_BAK}"
	mkdir -p ${CONF_BAK}
	if [ -f ~/.vimrc ]; then
		mv ~/.vimrc ${CONF_BAK}
	fi
	if [ -f ~/.bashrc ]; then
		mv ~/.bashrc ${CONF_BAK}
	fi
	if [ -f ~/.tmux.conf ]; then
		mv ~/.tmux.conf ${CONF_BAK}
	fi
	if [ -d ~/.vim ]; then
		mv ~/.vim ${CONF_BAK}
	fi
	if [ -d ~/.tmux ]; then
		mv ~/.tmux ${CONF_BAK}
	fi
	if [ -d ~/.gitconfig ]; then
		mv ~/.gitconfig ${CONF_BAK}
	fi
}

echo "${BLUE}"
cat << "HELLO_TEXT"
                          iiii
                         i::::i
                          iiii

vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm   rrrrr   rrrrrrrrr       cccccccccccccccc
 v:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm r::::rrr:::::::::r    cc:::::::::::::::c
  v:::::v       v:::::v   i::::i m::::::::::mm::::::::::mr:::::::::::::::::r  c:::::::::::::::::c
   v:::::v     v:::::v    i::::i m::::::::::::::::::::::mrr::::::rrrrr::::::rc:::::::cccccc:::::c
    v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m r:::::r     r:::::rc::::::c     ccccccc
     v:::::v v:::::v      i::::i m::::m   m::::m   m::::m r:::::r     rrrrrrrc:::::c
      v:::::v:::::v       i::::i m::::m   m::::m   m::::m r:::::r            c:::::c
       v:::::::::v        i::::i m::::m   m::::m   m::::m r:::::r            c::::::c     ccccccc
        v:::::::v        i::::::im::::m   m::::m   m::::m r:::::r            c:::::::cccccc:::::c
         v:::::v         i::::::im::::m   m::::m   m::::m r:::::r             c:::::::::::::::::c
          v:::v          i::::::im::::m   m::::m   m::::m r:::::r              cc:::::::::::::::c
           vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm rrrrrrr                cccccccccccccccc
HELLO_TEXT
echo "${NORMAL}"



os_check
perm_check
get_ip

echo "##########################################################"
echo "                  System Information"
echo "##########################################################"
echo "WHOAMI        : $WHOAMI"
echo "HOSTNAME      : $HOSTNAME"
echo "IP ADDRESS    : $IPADDR"
echo "OS            : $OS"
echo "DIST          : $DIST"
echo "DistroBasedOn : $DistroBasedOn"
echo "PSUEDONAME    : $PSUEDONAME"
echo "REV           : $REV"
echo "KERNEL        : $KERNEL"
echo "MACH          : $MACH"
echo "##########################################################"

echo "Installing git, ctags, cscope..."
if [ ${DistroBasedOn} = "Debian" ]; then
	$SUDO apt-get install -y ctags cscope git
elif [ ${DistroBasedOn} = "RedHat" ]; then
	$SUDO yum install -y ctags cscope git
else
	echo "${RED}Impossible to run this script in your computer, because it's not a recognizable distribution!!!${NORMAL}"
	exit
fi

echo "backup configuration files"
conf_backup

echo "Installing vim vundle..."
git clone ${VUNDLE_HTTPS} ~/.vim/

echo "Installing tmux plugin manager..."
mkdir -p ~/.tmux/plugins
git clone ${TPM_HTTPS} ~/.tmux/plugins/tpm

echo "copy configuration files to ~/"
cp .vimrc ~/
cp .bashrc ~/
cp .tmux.conf ~/
cp .gitconfig ~/

echo "copy mkcscope.sh to ~/.vim"
cp mkcscope.sh ~/.vim

cp ycm_extra_conf.py ~/.vim

echo "copy jellybeans colorschem to /usr/share/vim/vim74/colors/"
$SUDO cp jellybeans.vim /usr/share/vim/vim74/colors/
echo "copy molokai colorschem to /usr/share/vim/vim74/colors/"
$SUDO cp molokai.vim /usr/share/vim/vim74/colors/
echo "current set default colorschem is molokai..."

echo "install vim plugins"
vim +PluginInstall +qall
