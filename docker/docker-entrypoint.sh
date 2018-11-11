#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- elasticsearch "$@"
fi

# Run as user "elasticsearch" if the command is "elasticsearch"
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	set -- gosu elasticsearch tini -- "$@"
fi

exec "$@"
