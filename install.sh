#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"



main() {
     ln -s $PWD/gcln.sh $COMMANDS_DIR/gcln
     ln -s $PWD/setjava.sh $COMMANDS_DIR/setjava

     echo -e "\nsource $PWD/mybashrc.sh\n" >> $HOME/.bashrc

     set_vim
     set_go
}

set_vim() {
     mkdir $HOME/.vim
     ln -s $PWD/vimrc $HOME/.vim/vimrc

     # install vim plugin manager
     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

set_go() {
     set -e
     cd src/random-emoji
     go run gen_emojis.go
     go build -o randmj randmj.go
     rm emojis_zipped
     cd - > /dev/null
     sudo mv src/random-emoji/randmj $COMMANDS_DIR/.
}

main
