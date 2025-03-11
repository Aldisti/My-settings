#!/bin/bash

DEBUG=0

debug() {
	if [[ "$DEBUG" = "" || "$DEBUG" = "0" ]]; then
		return 0
	fi
	echo -e "DEBUG: $1"
}

set_version() {
	local JAVA_VERSIONS="$(update-java-alternatives --list | awk '{print $1}')"
	debug "versions: '$JAVA_VERSIONS'"

	if [ "$JAVA_VERSIONS" = "" ]; then
		echo -e "Error: no java version detected"
		return 1
	fi

	local SELECTED_VERSION="$(echo $JAVA_VERSIONS | tr ' ' '\n' | grep $1)"
	if [ "$SELECTED_VERSION" = "" ]; then
		echo -e "Error: selected version '$1' not found"
		return 1
	fi
	debug "selected versions: '$SELECTED_VERSION'"

	local ACTUAL_VERSION="$(java -version 2>&1 | head -1 | awk '{print $3}' | grep $1)"
	if ! [ "$ACTUAL_VERSION" = "" ] ; then
		debug "actual version: $ACTUAL_VERSION"
		echo -e "Version $1 already set"
		return 0
	fi

	debug "setting version to: '$SELECTED_VERSION'"
	sudo update-java-alternatives --set $SELECTED_VERSION
	echo -e "Version updated to $1"
}

if [ $# -eq 1 ]; then
	set_version $1
else
	echo -e "Error: usage 'setjava <8/17/21>'"
	exit 1
fi




