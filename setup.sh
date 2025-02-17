#!/bin/bash

# Autor : https://github.com/Riieiro


# Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


# Variables
ruta=$(pwd)
usuario=$(whoami)


# Ctrl + C
trap ctrl_c INT
function ctrl_c(){
	echo -e "\n\n${yellow}[✖]${red} Exiting...\n${end}"
	exit 1
}

clear
echo -e """
\e[38;5;88m



▀█████████▄     ▄████████    ▄███████▄  ▄█     █▄    ▄▄▄▄███▄▄▄▄      ▄████████    ▄████████     ███     ███    █▄     ▄███████▄ 
  ███    ███   ███    ███   ███    ███ ███     ███ ▄██▀▀▀███▀▀▀██▄   ███    ███   ███    ███ ▀█████████▄ ███    ███   ███    ███ 
  ███    ███   ███    █▀    ███    ███ ███     ███ ███   ███   ███   ███    █▀    ███    █▀     ▀███▀▀██ ███    ███   ███    ███ 
 ▄███▄▄▄██▀    ███          ███    ███ ███     ███ ███   ███   ███   ███         ▄███▄▄▄         ███   ▀ ███    ███   ███    ███ 
▀▀███▀▀▀██▄  ▀███████████ ▀█████████▀  ███     ███ ███   ███   ███ ▀███████████ ▀▀███▀▀▀         ███     ███    ███ ▀█████████▀  
  ███    ██▄          ███   ███        ███     ███ ███   ███   ███          ███   ███    █▄      ███     ███    ███   ███        
  ███    ███    ▄█    ███   ███        ███ ▄█▄ ███ ███   ███   ███    ▄█    ███   ███    ███     ███     ███    ███   ███        
▄█████████▀   ▄████████▀   ▄████▀       ▀███▀███▀   ▀█   ███   █▀   ▄████████▀    ██████████    ▄████▀   ████████▀   ▄████▀      
                                                                                                                                 


    							     ████████                           													
     	    						    ██████████                          													
           					           ████████████                         													
           				        	   ████████████                         													
         	 				          ██████████████                        													
      						      ██████████████████████                    													
      						      ██████████████████████                    
         					         ███ ████████ ███                       
          				                  ██    ██    ██                        
          				                  ██████████████                        
           					           ████████████                 
       						        ██████████████████                      
       						        ██████████████████                      
         					         ████████████████                       
      						      ██████████████████████                    
   						   ████████████████████████████                 
   						   ███████████${turquoise}Author\e[38;5;88m███████████                 
  						  ██████████████████████████████                        
 					         ███${yellow}https://github.com/Riieiro\e[38;5;88m███                          
  						  ██████████████████████████████                        
      						      ██████████████████████                    
\e[0m
"""






# Comprobar distribución
if [ "$(lsb_release -a | grep Distributor | awk '{print $NF}')" != "Kali" ]; then
	echo -e "\n${yellow}[✖]${red} The distribution is not Kali linux, it is possible that the environment is not installed correctly.\n"
	sleep 0.5
fi

# Comprobar privilegios
if [ "$usuario" == "root" ]; then
	echo -e "\n${yellow}[✖]${red} It is not possible to run the script with the root user.\n"
	exit 1
fi


##Instalar Requerimientos##
###########################

# Dependencias iniciales
echo -e "\n${yellow}[ℹ]${gray} Installing essential packages...\n${end}"
sleep 1
sudo apt install p7zip-full net-tools curl zsh rofi imagemagick build-essential git vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev feh jq libxcb1 libxcb1-dev xcb-proto python3-xcbgen -y
if [ $? != 0 ] && [ $? != 130 ]; then
	echo -e "\n${yellow}[✖] Failed to install some packages.\n${end}"
	exit 1
else
	echo -e "\n${yellow}[✔]${green} Done\n${end}"
	sleep 1.5
fi

# Bspwm y Sxhkd
echo -e "\n${yellow}[ℹ]${gray} Installing bspwm & sxhkd...\n${end}"
sleep 1
sudo apt install bspwm -y
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
cd bspwm && make
sleep 0.5
sudo make install
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install bspwm.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
cd ../sxhkd && make
sleep 0.5
sudo make install
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install sxhkd.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
cd ..
sudo rm -rf bspwm sxhkd



# Kitty
echo -e "\n${yellow}[ℹ]${gray} Installing kitty...\n${end}"
sleep 1
if [ ! -e /opt/kitty ];then
	sudo mkdir /opt/kitty
	7z x kitty.7z
	rm kitty.7z
	sudo mv kitty/kitty-0.39.1-x86_64.tar /opt/kitty
	cd /opt/kitty
	sudo tar -xf kitty-0.39.1-x86_64.tar
	sudo rm -f kitty-0.39.1-x86_64.tar
	cd $ruta
	rm -f kitty.7z
	echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
else
	sudo apt install kitty -y
fi


# Picom
echo -e "\n${yellow}[ℹ]${gray} Installing picom...\n${end}"
sleep 1
sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev -y
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install some packages.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
git clone https://github.com/yshui/picom.git
cd picom
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install picom.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
cd $ruta
rm -rf picom

# Fuentes
echo -e "\n${yellow}[ℹ]${gray} Moving fonts...\n${end}"
sudo mkdir -p /usr/local/share/fonts /usr/share/wallpapers
sudo mv fonts/* /usr/local/share/fonts/
sudo fc-cache -fv 


# Fondos
echo -e "\n${yellow}[ℹ]${gray} Moving wallpapers...\n${end}"
sudo mv wallpaper/* /usr/share/wallpapers/


# Polybar
echo -e "\n${yellow}[ℹ]${gray} Installing polybar...\n${end}"
sudo apt install polybar -y
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install polybar.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi


# Plugins
echo -e "\n${yellow}[ℹ]${gray} Installing zsh plugins...\n${end}"
sudo apt install zsh-autosuggestions zsh-syntax-highlighting -y
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install zsh plugins.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
sudo mv plugins/zsh-syntax-highlighting.zsh /usr/share/zsh-syntax-highlighting
sudo mkdir /usr/share/zsh-autocomplete
sudo mv plugins/zsh-autocomplete.plugin.zsh /usr/share/zsh-autocomplete
sudo mkdir /usr/share/sudo.plugin
sudo mv plugins/sudo.plugin.zsh /usr/share/sudo.plugin



# Powerlevel 10k
echo -e "\n${yellow}[ℹ]${gray} Installing powerlevel10k...\n${end}"
sudo usermod --shell /usr/bin/zsh root
sudo usermod --shell /usr/bin/zsh $usuario
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
sudo apt install zsh-autosuggestions zsh-syntax-highlighting -y
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install powerlevel10k.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
sudo mv ~/powerlevel10k /usr/share/
sudo chown -R root:root /usr/local/share/zsh/site-functions

# Bat y lsd
echo -e "\n${yellow}[ℹ]${gray} Installing bat...\n${end}"
sudo dpkg -i bat/bat_0.25.0_amd64.deb
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install bat.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
echo -e "\n${yellow}[ℹ]${gray} Installing lsd...\n${end}"
sudo dpkg -i bat/lsd_1.1.5_amd64.deb
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install lsd.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
export LS_COLORS="$(echo $LS_COLORS|sed 's/=01;/=/g')"

# Neofetch
echo -e "\n${yellow}[ℹ]${gray} Installing neofetch...\n${end}"
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
sudo make install
if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${yellow}[✖] Failed to install neofetch.\n${end}"
        exit 1
else
        echo -e "\n${yellow}[✔]${green} Done\n${end}"
        sleep 1.5
fi
cd ..
rm -rf neofetch


# Configuración de archivos
echo -e "\n${yellow}[ℹ]${gray} Configuring configuration files...\n${end}"
mv kitty config/
sudo chmod +x -R config/
sudo cp -r config/neofetch /root/.config/
mv config/* ~/.config/
cp zsh/zshrc ~/.zshrc
sudo mv zsh/zshrc /root/.zshrc
mv zsh/p10k.zsh ~/.p10k.zsh
sudo mv zsh/pk10_root.zsh /root/.p10k.zsh
echo -e "\n${yellow}[✔]${green} Done\n${end}"
sleep 1.5


while true; do
	echo -en "\n${yellow}[ℹ]${gray} It's necessary to restart the system. Do you want to restart the system now? ([y]/n) ${end}"
	read -r
	REPLY=${REPLY:-"y"}
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e "\n\n${yellow}[✔] ${green}Restarting the system...\n${endC}"
		sleep 1
		sudo reboot
	elif [[ $REPLY =~ ^[Nn]$ ]]; then
		exit 0
	else
		echo -e "\n${yellow}[✖]${red} Invalid response, please try again.\n${end}"
	fi
done
