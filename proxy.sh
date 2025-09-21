#!/bin/bash

set -e

CONF_DIR="$HOME/.proxy"
VENV_DIR="$CONF_DIR/venv"

# 1: listening port
# 2: destination url
main() {
	if [ "$#" != "2" ]; then
		echo -e "Usage: proxy <listening_port> <destination_url>"
		exit 1
	fi
	__check_venv
	set +e
	mitmproxy --mode "reverse:$2" --listen-port "$1" --set keep_host_header
	set -e
	deactivate
}

__check_venv() {
	mkdir -p "$CONF_DIR"
	if [ ! -d "$VENV_DIR" ]; then
		python3 -m venv "$VENV_DIR"
	fi
	source "$VENV_DIR/bin/activate"
	pip -q install mitmproxy
}

main $@

