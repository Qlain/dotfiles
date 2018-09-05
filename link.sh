#!/bin/bash

ln -sf ~/dotfiles/.vimrc /etc/vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.xsession ~/.xsession
ln -sf ~/dotfiles/.xmobarrc ~/.xmobarrc
mkdir ~/.xmonad
ln -sf ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
