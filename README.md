
# bspwm-setup

bspwm-setup is a bash script designed to automatically set up a custom bspwm environment for https://github.com/Riieiro. 

## Prerequisites

A Debian-based Linux distribution (preferably Kali Linux)

## Installation

1. Update repository:
```bash
sudo apt update -y
sudo apt upgrade -y
```
2. Clone the repository:  
```bash
git clone https://github.com/Riieiro/bspwm-setup.git
cd bspwm-setup
```
3. Make the script executable:
```bash
chmod +x setup.sh
```
4. Run the script:
```bash
./setup.sh
```
5. Follow the on-screen instructions and restart your system when prompted.

## Usage

Once the environment is installed, you need to change it in the login panel:

![Pasted image 20250216231829](https://github.com/user-attachments/assets/4bd65aef-2148-4732-80a0-1b191f0169af)

## Overview
![imagen](https://github.com/user-attachments/assets/5d27f12c-ae04-4808-b329-91f8deff3794)
![imagen](https://github.com/user-attachments/assets/9708ab8a-362a-44bf-a1cb-fcc62cd5891a)
![imagen](https://github.com/user-attachments/assets/a28a5c37-6828-4a18-abfe-b2e24cabbdae)
![imagen](https://github.com/user-attachments/assets/02128d09-a90e-4ee0-886f-4cc5f5cf1eb6)

# Keybindings for bspwm

- **Terminal**: `super + Return` → Opens `kitty`
- **Program Launcher**: `super + d` → Opens `rofi`
- **Reload sxhkd**: `super + Escape` → Reload configuration

- **Quit/Restart bspwm**: `super + shift + {q,r}`
- **Close/Kill Window**: `super + {_,shift + }q`
- **Tiled/Monocle Layout**: `super + m`
- **Swap Nodes**: `super + g`
- **Set Window State**: `super + {t,shift + t,s,f}`

- **Focus Direction**: `super + {_,shift + }{Left,Down,Up,Right}`
- **Focus Next/Prev Window**: `super + {_,shift + }c`
- **Focus Last Node/Desktop**: `super + {grave,Tab}`
- **Focus Desktop**: `super + {_,shift + }{1-9,0}`

- **Preselect Direction**: `super + ctrl + alt + {Left,Down,Up,Right}`
- **Cancel Preselection**: `super + ctrl + alt + space`

- **Move Window**: `super + shift + {Left,Down,Up,Right}`
- **Custom Resize**: `super + alt + {Left,Down,Up,Right}`

- **Firefox**: `super + shift + f`
- **Burpsuite**: `super + shift + b`

## Uninstallation

To remove BSPWM and related components, manually delete the installed packages and configurations:

```bash
sudo apt remove --purge bspwm sxhkd rofi polybar kitty picom zsh neofetch bat lsd -y rm -rf ~/.config/bspwm ~/.config/sxhkd ~/.config/polybar ~/.config/rofi ~/.config/kitty ~/.config/picom ~/.zshrc ~/.p10k.zsh ~/Pictures/Wallpapers ~/.local/share/fonts
```

## Credits

- **Author:** [Riieiro](https://github.com/Riieiro)
- **Concept**: [s4vitar](https://hack4u.io/cursos/personalizacion-de-entorno-en-linux/) 
