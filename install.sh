#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"
ROOT_DIR="$PWD/$(dirname $0)"
CMDS_DIR="$ROOT_DIR/commands"
CONFS_DIR="$ROOT_DIR/confs"

main() {
    set_commands
    set_bashrc
    set_vim
    set_ghostty
    set_go
}

set_commands() {
    if ! ask_bool "Install all the commands?"; then
        return 0
    fi
    sudo ln -fs $CMDS_DIR/gcln $COMMANDS_DIR/gcln
    sudo ln -fs $CMDS_DIR/setjava $COMMANDS_DIR/setjava
    sudo ln -fs $CMDS_DIR/gentok $COMMANDS_DIR/gentok
    sudo ln -fs $CMDS_DIR/proxy $COMMANDS_DIR/proxy
}

set_bashrc() {
    if ! ask_bool "Set up bashrc?"; then
        return 0
    fi
    echo -e "\nexport MY_BASHRC=$CONFS_DIR/bashrc" >> $HOME/.bashrc
    echo -e "source \$MY_BASHRC\n" >> $HOME/.bashrc
}

set_vim() {
    if ! ask_bool "Set up vimrm?"; then
        return 0
    fi
    mkdir -p $HOME/.vim
    ln -fs $CONFS_DIR/vimrc $HOME/.vim/vimrc

    if ! ask_bool "Install vim plugin for indentation?"; then
        return 0
    fi
    # install vim plugin manager
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

set_go() {
    if ! ask_bool "Compile and install randmj?"; then
        return 0
    fi
    set -e
    cd $ROOT_DIR/src/random-emoji
    go run gen_emojis.go
    go build -o randmj randmj.go
    rm emojis_zipped
    cd - > /dev/null
    sudo mv $ROOT_DIR/src/random-emoji/randmj $COMMANDS_DIR/.
}

set_ghostty() {
    if ! ask_bool "Set up ghostty config?"; then
        return 0
    fi
    mkdir -p $HOME/.config/ghostty
    ln -fs $CONFS_DIR/ghostty.config $HOME/.config/ghostty/config
}

# 1: message (without [Y/n])
# Usage: if ask_bool "Do you want it?"; then ...; fi
ask_bool() {
    read -p "$1 [Y/n] " res
    if [[ "$res" =~ ^[nN]$ ]]; then
        return 1 # false
    else
        return 0 # true
    fi
}

echo -e "COMMANDS_DIR: $COMMANDS_DIR"
echo -e "ROOT_DIR: $ROOT_DIR"

main
