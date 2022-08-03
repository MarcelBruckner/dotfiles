#!/usr/bin/bash

# Start internet
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

# Install packages
sudo pacman -Syyu
sudo pacman -S --needed git base-devel
sudo pacman -Syu neovim xorg-server xorg-apps plasma-meta \
    alacritty chromium neofetch htop zsh \
    xmonad xmonad-contrib \
    dolphin ark konsole \
    dmenu networkmanager-openvpn \
    reflector \
    bluez bluez-utils pulseaudio-bluetooth \
    firefox \
    jdk8-openjdk jdk11-openjdk jdk17-openjdk \
    ripgrep \
    ranger ttf-nerd-fonts-symbols

git clone https://github.com/NvChad/NvChad $HOME/.config/nvim --depth 1 && nvim

# Relevant services
sudo systemctl enable sddm
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now bluetooth

# Setup git
git config --global user.name "bruckner"
git config --global user.email "bruckner@cqse.eu"

# Install yay 
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si
yay
yay -Y --gendb
yay -Syu --devel
yay -Y --devel --save

# Install ZSH
mkdir $HOME/Repositories
cd Repositories/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install ZSH and plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
yay meslo
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Setup ranger
git clone https://github.com/alexanderjeurissen/ranger_devicons $HOME/.config/ranger/plugins/ranger_devicons
ranger --copy-config=rc
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf

# Setup XMonad for KDE
mkdir -p $HOME/.config/systemd/user/
ln -s $PWD/plasma-custom-wm.service $HOME/.config/systemd/user/
sudo systemctl mask plasma-kwin_x11
systemctl --user daemon-reload
systemctl --user enable $HOME/.config/systemd/user/plasma-custom-wm.service\
yay picom-jonaburg

# Link dotfiles
for CONFIG_DIR in alacritty nvim picom ranger mimeapps.list
do
    rm -rf $PWD/$CONFIG_DIR 
    ln -s $PWD/$CONFIG_DIR $HOME/.config
done

for ALIAS_FILE in $PWD/aliases/
do
    ln -s $ALIAS_FILE $HOME/
done

rm -rf $HOME/.zshrc
ln -s $PWD/.zshrc $HOME/
rm -rf $PWD/.xmonad 
ln -s $PWD/.xmonad $HOME/
ln -s $PWD/nvim/lua/custom $HOME/.config/nvim/lua/

# CQSE stuff
sudo archlinux-java set java-11-openjdk

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node # "node" is an alias for the latest version
sudo npm install -g pnpm

yay 1password
yay jetbrains-toolbox
yay slack
