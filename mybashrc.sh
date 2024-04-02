#!/bin/sh

# Bash Prompt
# export PS1='\\[\e[1;32m\\]\u@\s\\[\e[0m\\]:\\[\e[1;34m\\]\W\\[\e[0m\\]\$ '
# srcs: https://phoenixnap.com/kb/change-bash-prompt-linux
# To change the color of the '@' based on the exit code of the last executed command
# Put in place of '@' the following function:
# __color_status() { if [ $? -eq 0 ]; then echo -e "@"; else echo -e "\033[1;31m@\033[1;32m"; fi }
# So the PS1 will be: '...\u`__color_status`\s...'

# to make your workspaces on different monitors independents
# gsettings set org.gnome.mutter workspaces-only-on-primary true

# to run a command on a new terminal
# gnome-terminal -- <command>

# how to make linux use local time instead of UTC
# timedatectl set-local-rtc 1 --adjust-system-clock
# how to undo it (and use UTC)
# timedatectl set-local-rtc 0 --adjust-system-clock

# how to disable descrete GPU
# sudo prime-select <nvidia|intel|on-demand|query>

# how to have intel syntax on gdb
# set disassembly-flavor intel
# to make it permanent put the command inside ~/.gdbinit

# how to make ignore-case the autocompletion
# go in /etc/inputrc and search for it

# if you want to have a partial history
# bind arrow-[up|down] to history-search-[forward|backward]
# inside the /etc/inputrc



# check the current shell and switch the rc file
if [ "$SHELL" = "/bin/zsh" ]; then
	SPT_RC="~/.zshrc"
else
	SPT_RC="~/.bashrc"
fi
# some rc shortcuts
alias erc="vim $SPT_RC"
alias vrc="vim ~/.vimrc"
alias mrc="vim ~/.mybashrc"
alias irc="sudo vim /etc/inputrc"

# updates the 'bashrc' or 'zshrc' that the actual terminal is using
alias reload="source $SPT_RC"

# some general shortcuts
alias wai="clear && pwd && ls"
alias cp="cp -r"
alias lr="ls -R"
alias kll="kill -kill"
alias nt="gnome-terminal --"
alias curl="curl $@ && echo"

# git shortcuts
alias gcln="git clone"
alias gpll="git pull"
alias gstt="git status"
alias gsth="git stash"
alias gswt="git switch"
alias gmrg="git merge"
alias glog="git log"
alias gpsh="git push"
alias gcmt="git commit"
alias gadd="git add"
alias  grm="git rm"

# docker shortcuts
alias dps="docker ps"
alias drm="docker rm"
alias dins="docker inspect"
alias dimg="docker image"
alias dvol="docker volume"
alias dnet="docker network"
alias dsp="docker system prune"
alias dcmp="docker compose"
alias dexe="docker exec"
alias dbld="docker build"
alias drun="docker run"

# compile C files with some basic flags
alias ccc="gcc -Wall -Wextra -Werror"
# compile C++ files with some basic flags and C++98 version
alias ggg="g++ -Wall -Wextra -Werror -std=c++98"
# executes python programs
alias py="python3"

# check for leaks with valgrind
alias leaks="valgrind --leak-check=full --show-leak-kinds=all"

# update your computer (only if you are in sudoersi)
alias update="sudo apt-get update && sudo apt-get upgrade -y"
# opens a random wiki page (you need 'open' command)
alias wiki="xdg-open https://en.wikipedia.org/wiki/Special:Random &"

# oblique strategies
# files in /usr/share/games/fortune/
# to create the file .dat from the normal text file
# use the command strfile
alias oblique="fortune oblique"

# clean vim undo cache
alias cleanvim="rm -f ~/.vim/undo/*"

# some cd shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

