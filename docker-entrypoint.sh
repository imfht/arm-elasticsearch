#!/bin/bash

set -e

# ERROR: [1] bootstrap checks failed
# [1]: JVM is using the client VM [OpenJDK Client VM] but should be using a server VM for the best performance
# Will this work?
export ES_JAVA_OPTS="$ES_JAVA_OPTS -server -Djna.tmpdir=/var/lib/elasticsearch/tmp"

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change the ownership of user-mutable directories to elasticsearch
	for path in \
		/usr/share/elasticsearch \
		/etc/elasticsearch \
		/var/log/elasticsearch \
	; do
		chown -R elasticsearch:elasticsearch "$path"
	done
	
	set -- gosu elasticsearch "$@"
	#exec gosu elasticsearch "$BASH_SOURCE" "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
