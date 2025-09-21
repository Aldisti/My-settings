#!/bin/bash


RESET="\033[0m"
GREEN="\033[32;1m"
RED="\033[31;1m"
CYAN="\033[36;1m"

DEBUG="false"
QUIET="false"
DEFAULT_SIZE=16

ROOT_DIR="$PWD/$(dirname $0)"

# 1 (int): token size
__base64() {
	local token=$(openssl rand -base64 $1)
	echo -e "$token"
}

# no params
__sha256() {
	local token="$(cat /dev/urandom | head -30 | sha256sum | awk '{print $1}')"
	echo -e "$token"
}

# no params
__uuid() {
	echo -e "$(uuidgen)"
}

__help() {
	echo -e "./gentok [OPTIONS] <uuid|sha256|base64> [SIZE]"
	echo
	echo -e "commands:"
	echo -e "\tuuid, id:\t\tprints a uuid."
	echo -e "\tsha256, 256, sha:\tprints a random bytes hashed with sha256."
	echo -e "\tbase64, 64, b64:\tprints a base64 encoded token of length SIZE."
	echo
	echo -e "options:"
	echo -e "\t-q, --quiet:\tdisables all outputs except for errors and results."
	echo -e "\t-d, --debug:\tenables debugging mode, is not affected by -q."
	echo -e "\t-h, --help:\tshows this page."
}

main() {
	while [ $# -gt 0 ]; do
		opt="$(echo $1 | tr 'A-Z' 'a-z')"
		shift
		case ${opt} in
			base64 | 64 | b64)
				local size=${1:-$DEFAULT_SIZE}
				if [ "$size" != "$DEFAULT_SIZE" ]; then shift; fi
				__debug "Mode: base64 - Size: $size"
				__base64 "$size"
				return $?
			;;
			sha256 | sha | 256)
				__debug "Mode: sha256 - Size: fixed"
				__sha256
				return $?
			;;
			uuid | id)
				__debug "Mode: uuid - Size: fixed"
				__uuid
				return $?
			;;
			-q | --quiet)
				QUIET="true"
			;;
			-d | --debug)
				DEBUG="true"
				__debug "Enabled debug logs"
			;;
			-h | --help | -?)
				__debug "Showing helper"
				__help
			;;
			*)
				__error "Invalid argument '$opt'"
				exit 1
			;;
		esac
	done
}

# 1: type
# 2: color
# 3: message
__log() {
	echo -e "$2$1$RESET: $3"
}

__debug() {
	if [ "$DEBUG" = "true" ]; then
		__log "DEBUG" $CYAN "$1"
	fi
}

__info() {
	if [ "$QUIET" != "true" ]; then
		__log "INFO" $GREEN "$1"
	fi
}

__error() {
	__log "ERROR" $RED "$1"
}

set -e

main $@

