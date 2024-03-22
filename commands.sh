
function go()
{
	if [ $# -gt 1 ]; then
		echo "'go' command too many arguments"
		return 1
	fi
	cd $HOME/Documents/42Cursus/$1/$2 2>/dev/null
	if ! [ $? -eq 0 ]; then
		echo "'go' command cannot find HOME"
		return 1
	fi
	clear
	pwd
	ls
	return 0
}

function push()
{
	if [ $# -eq 0 ]; then
		git add . && git commit -m "auto push" && git push
	else
		git add . && git commit -m "$@" && git push
	fi
	return 0
}

function exe()
{
	if [ "$(ls | grep 'Makefile')" = "" ]; then # check if Makefile exists
		printf "\033[31mexec: Makefile not found\n\033[0m"
	else # if Makefile exists then do 'make re'
		make re
		if ! [ $? -eq 0 ]; then # if 'make re' fails stop the command
			printf "\033[31mexec: makefile error\n\033[0m"
			return $?
		fi
	fi
	clear
	local FILE=".exec.out" # temporary file
	local exe="null" # name of the executable
	ls -l | grep '\-x' > $FILE # saves all the files with execution permissions in a new file
	while read line; do # cycle on all the lines of $FILE
		if ! [ "$(echo $line | head -c 1)" = "d" ]; then # the first file that's not a directory
			exe=$(echo $line | grep -oE '[^[:space:]]+$') # is the file that will be executed
			break
		fi
	done <"$FILE" # idk

	rm -f $FILE > /dev/null 2>&1 # deletes the temporary file
	if [ "$1" = "-e" ]; then # use a specific name for the executable
		shift
		exe="$1"
		shift
	fi

	if [ "$exe" = "null" ]; then # check if an executable was found
		printf "\033[31mexec: no executable found\n\033[0m" # if not, stop the command
		return 1
	fi

	# execute the file with the parameters passed to this command
	if [ "$1" = "-v" ]; then # execute with valgrind
		shift
		valgrind ./$exe $@
	elif [ "$1" = "-l" ]; then # execute with valgrind --leak-check=full
		shift
		valgrind --leak-check=full ./$exe $@
	else
		./$exe $@
	fi
}

