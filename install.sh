#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"

ln -s $PWD/gcln.sh $COMMANDS_DIR/gcln
ln -s $PWD/setjava.sh $COMMANDS_DIR/setjava

echo -e "\nsource $PWD/mybashrc.sh\n" >> $HOME/.bashrc

mkdir $HOME/.vim
ln -s $PWD/vimrc $HOME/.vim/vimrc

# install vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

