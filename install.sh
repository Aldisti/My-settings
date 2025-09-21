#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"
ROOT_DIR="$PWD/$(dirname $0)"
CMDS_DIR="$ROOT_DIR/commands"
CONFS_DIR="$ROOT_DIR/confs"

main() {
	sudo ln -fs $CMDS_DIR/gcln $COMMANDS_DIR/gcln
    sudo ln -fs $CMDS_DIR/setjava $COMMANDS_DIR/setjava
    sudo ln -fs $CMDS_DIR/gentok $COMMANDS_DIR/gentok
    sudo ln -fs $CMDS_DIR/proxy $COMMANDS_DIR/proxy

    echo -e "\nexport MY_BASHRC=$CONFS_DIR/bashrc" >> $HOME/.bashrc
    echo -e "source \$MY_BASHRC\n" >> $HOME/.bashrc

    set_vim
    set_go
}

set_vim() {
    mkdir -p $HOME/.vim
    ln -fs $CONFS_DIR/vimrc $HOME/.vim/vimrc

    # install vim plugin manager
    # curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    #     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

set_go() {
    set -e
    cd $ROOT_DIR/src/random-emoji
    go run gen_emojis.go
    go build -o randmj randmj.go
    rm emojis_zipped
    cd - > /dev/null
    sudo mv $ROOT_DIR/src/random-emoji/randmj $COMMANDS_DIR/.
}

echo -e "COMMANDS_DIR: $COMMANDS_DIR"
echo -e "ROOT_DIR: $ROOT_DIR"

main
