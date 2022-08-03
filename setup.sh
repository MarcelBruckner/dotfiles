#!/usr/bin/bash

for CONFIG_DIR in alacritty nvim picom ranger mimeapps.list
do
    ln -s $PWD/$CONFIG_DIR $HOME/.config
done

ln -s $PWD/.xmonad $HOME/
ln -s $PWD/nvim/lua/custom $HOME/.config/nvim/lua/


