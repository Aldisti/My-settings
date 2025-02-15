#!/bin/bash

RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

CONFIG_FILE="${HOME}/.gclnrc"

declare -A credentials

__debug() {
	if ! [ "${DEBUG}" = "" ]; then
		echo -e "${YELLOW}DEBUG${RESET}: ${1}"
	fi
}

__error() {
	if [ "${QUIET}" = "" ]; then
		echo -e "${RED}ERROR${RESET}: ${1}"
	fi
}

__load_map() {
	if ! [ -f "${CONFIG_FILE}" ]; then
		__debug "config file '${CONFIG_FILE}' not found"
		return 0
	fi

	while IFS= read -r line; do
		if [ "${line}" = "" ]; then
			continue
		fi

		__debug "parsing line |${line}|"

		key="${line%% *}"
		value="${line#* }"

		__debug "key |${key}| value |${value}|"

		if [ "${key}" = "" ] || [ "${value}" = "" ]; then
			echo -e "Error: invalid map file format at line '${line}'"
			exit 1
		fi

		credentials["$key"]="$value"
	done < "${CONFIG_FILE}"
}

__detect() {
	for key in "${!credentials[@]}"; do
		if grep -qe "${key}" <<< "${@: -1}"; then
			DIR_NAME="$(basename ${@: -1} .git)"	
		elif grep -qe "${key}" <<< "${@: -2:1}"; then
			DIR_NAME="${@: -1}"
		else
			__debug "|${key}| not in |$1| or |${@: -1}| or |${@: -2:1}|"
			continue
		fi

		__debug "dirname: |${DIR_NAME}|"
		__debug "detected credentials: |$key| |${credentials[$key]}|"

		DETECTED_KEY="$key"
		DETECTED_CREDENTIALS="${credentials[$key]}"
		break
	done
}

__load_map
__detect $@


git clone $@
if ! [ $? -eq 0 ]; then
	exit $?
fi  


if [ "${DETECTED_CREDENTIALS}" = "" ]; then
	echo "Warn: didn't detect credentials. Try updating them."
	exit 0
fi

D_NAME=${DETECTED_CREDENTIALS%%|*}
D_EMAIL=${DETECTED_CREDENTIALS#*|}

__debug "name: |${D_NAME}| email: |${D_EMAIL}|"

cd "${DIR_NAME}"

git config user.name "${D_NAME}"
git config user.email "${D_EMAIL}"

cd - >/dev/null

if [ "${QUIET}" = "" ]; then
	echo -e "Name: ${CYAN}${D_NAME}${RESET}"
	echo -e "Email: ${CYAN}${D_EMAIL}${RESET}"
fi

