#!/usr/bin/env bash

service elasticsearch start
tail -f /var/log/elasticsearch/elasticsearch.log
