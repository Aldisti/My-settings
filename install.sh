#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"
ROOT_DIR="$PWD/$(dirname $0)"

main() {
	sudo ln -fs $ROOT_DIR/gcln $COMMANDS_DIR/gcln
    sudo ln -fs $ROOT_DIR/setjava $COMMANDS_DIR/setjava
    sudo ln -fs $ROOT_DIR/gentok $COMMANDS_DIR/gentok
    sudo ln -fs $ROOT_DIR/proxy $COMMANDS_DIR/proxy

    echo -e "export MY_BASHRC=$ROOT_DIR/bashrc" >> $HOME/.bashrc
    echo -e "\nsource \$MY_BASHRC\n" >> $HOME/.bashrc

    set_vim
    set_go
}

set_vim() {
    mkdir -p $HOME/.vim
    ln -s $ROOT_DIR/vimrc $HOME/.vim/vimrc

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

echo -e "COMMANDS_DIR: $COMMANDS_DIR"
echo -e "ROOT_DIR: $ROOT_DIR"

main
