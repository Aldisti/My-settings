#!/bin/bash

# run this script to setup everything
# it creates links to make available the gcln and setjava commands

COMMANDS_DIR="/usr/local/bin"
ROOT_DIR="$(dirname $0)"

main() {
	ln -fs $ROOT_DIR/gcln.sh $COMMANDS_DIR/gcln
    ln -fs $ROOT_DIR/setjava.sh $COMMANDS_DIR/setjava
    ln -fs $ROOT_DIR/gentok.sh $COMMANDS_DIR/gentok
    ln -fs $ROOT_DIR/proxy.sh $COMMANDS_DIR/proxy

    echo -e "\nsource $ROOT_DIR/mybashrc.sh\n" >> $HOME/.bashrc

    set_vim
    set_go
}

set_vim() {
    mkdir $HOME/.vim
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
