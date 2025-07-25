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
# go in /etc/inputrc

# how to list all listening ports
# sudo lsof -i -P -n | grep LISTEN

# where should I store one of my commands?
# /usr/local/bin
# more info: https://askubuntu.com/a/465209

# how to unstage added untracked files in git
# git rm --cached --ignore-unmatch -r .

BLUE="\033[38;5;21m"
CYAN="\033[38;5;81m"
GREEN="\033[38;5;40m"
ORANGE="\033[38;5;202m"
PURPLE="\033[35;1m"
RED="\033[38;5;124m"
WHITE="\033[38;5;231m"
YELLOW="\033[38;5;226m"
RESET="\033[0m"
MC="\033[37m"

ECHO_COLOR="echo -ne "

# check the current shell and switch the rc file
if [ "$SHELL" = "/bin/zsh" ]; then
	SPT_RC="~/.zshrc"
else
	SPT_RC="~/.bashrc"
fi
# some rc shortcuts
alias erc="vim ${SPT_RC}"
alias vrc="vim ~/.vim/vimrc"
alias mrc="vim ${MY_BASHRC}"
alias irc="sudo vim /etc/inputrc"
alias vhosts="sudo vim /etc/hosts"

# updates the 'bashrc' or 'zshrc' that the actual terminal is using
alias reload="source ${SPT_RC}"

# some general shortcuts
alias wai="clear && ${ECHO_COLOR}'${PURPLE}' && pwd && ${ECHO_COLOR}'${RESET}' && ls"
alias cp="cp -r"
alias lr="ls -R"
alias kll="kill -kill"
alias nt="gnome-terminal --"
# alias curl="curl $@ && echo"

# clean linux cache
alias cleancache="echo 1 | sudo tee /proc/sys/vm/drop_caches > /dev/null"
# show listening ports
alias ports="lsof -i -n -P | grep LISTEN"

# git shortcuts
#alias gcln="git clone"
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
alias gchp="git cherry-pick"

# git "longcuts"
alias ggraph="git log --graph --oneline"
alias gconfe="git config user.email 'alessandro.distefano@leonardo.com'"
alias gconfu="git config user.name 'Alessandro Di Stefano'"
alias gremup="git remote update"
alias gchpnc="git cherry-pick --no-commit"

# docker shortcuts
alias dps="docker ps"
alias drm="docker rm"
alias dins="docker inspect"
alias dimg="docker image"
alias dvol="docker volume"
alias dnet="docker network"
# alias dsp="docker system prune"
alias dsp="echo -e 'dsp alias not available'"
alias dcmp="docker compose"
alias dexe="docker exec"
alias dbld="docker build"
alias drun="docker run"
alias dclean='drm -f $(dps -aq) && dimg rm -f $(dimg ls -aq) && dvol rm -f $(dvol ls -q)'
alias dcstart='drm -f $(dps -aq); dimg rm -f $(dimg ls -aq); dvol rm $(dvol ls -q); dcmp up'

function dimgrmnone() {
	dimg rm $(dimg ls -a | grep none | awk '{print $3}' | tr '\n' ' ')
}

# compile C files with some basic flags
alias ccc="gcc -Wall -Wextra -Werror"
# compile C++ files with some basic flags and C++98 version
alias ggg="g++ -Wall -Wextra -Werror -std=c++98"
# executes python programs
alias py="python3"
alias venv="python3 -m venv .venv && source .venv/bin/activate"

# check for leaks with valgrind
alias leaks="valgrind --leak-check=full --show-leak-kinds=all"

# update your computer (only if you are in sudoersi)
alias update="sudo apt-get update && sudo apt-get upgrade -y"
# opens a random wiki page (you need 'open' command)
alias wiki="xdg-open https://en.wikipedia.org/wiki/Special:Random &"

#alias intellij="intellij-idea-ultimate . >/dev/null 2>&1 &"

# Alias for a batcat command that doesn't print line numbers
alias batnonum="batcat --style changes,header-filename"

# oblique strategies
# files in /usr/share/games/fortune/
# to create the file .dat from the normal text file
# use the command strfile
alias oblique="fortune oblique"

# clean vim undo cache
alias cleanvim="rm -f ~/.vim/undo/*"

gentok() {
	local size="$1"
	if [ "$size" = "" ]; then
		local size="15"
	fi
	openssl rand -base64 $size
}

# some cd shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

export PATH="/home/aldisti/Documents/ESA/sonar-scanner/bin:$PATH"

