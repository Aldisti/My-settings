# bash prompt
# export PS1='\\[\e[1;32m\\]\u@\s\\[\e[0m\\]:\\[\e[1;34m\\]\W\\[\e[0m\\]\$ '
# srcs: https://phoenixnap.com/kb/change-bash-prompt-linux

# check the current shell and switch the rc file
if [ "$SHELL" = "/bin/zsh" ]; then
	SPT_RC="~/.zshrc"
else
	SPT_RC="~/.bashrc"
fi

# updates the 'bashrc' or 'zshrc' that the actual terminal is using
alias reload="source $SPT_RC"

# some general shortcuts
alias wai="clear && pwd && ls"
alias cp="cp -r"
alias lr="ls -R"
alias kll="kill -kill"
alias erc="vim $SPT_RC"
alias vrc="vim ~/.vimrc"

# git shortcuts
alias gcln="git clone"
alias gpll="git pull"
alias gstt="git status"
alias gswt="git switch"
alias gmrg="git merge"

# docker shortcuts
alias dps="docker ps"
alias drm="docker rm"
alias disp="docker inspect"
alias dils="docker image ls"
alias dirm="docker image rm"
alias dvls="docker volume ls"
alias dvrm="docker volume rm"
alias dvcr="docker volume create"
alias dnls="docker network ls"
alias dnrm="docker network rm"
alias dncr="docker network create"

# compile C files with some basic flags
alias ccc="gcc -Wall -Wextra -Werror"
# compile C++ files with some basic flags and C++98 version
alias ggg="g++ -Wall -Wextra -Werror -std=c++98"
# executes python programs
alias py="python3"
# check for leaks with valgrind
alias leaks="valgrind --leak-check=full"

# update your computer (only if you are in sudoersi)
alias update="sudo apt-get update && sudo apt-get upgrade"
# opens a random wiki page (you need 'open' command)
alias wiki="xdg-open https://en.wikipedia.org/wiki/Special:Random"
