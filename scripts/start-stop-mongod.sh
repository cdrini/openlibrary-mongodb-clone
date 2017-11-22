#!/bin/bash

usage() { echo $"Usage: $0 MONGO_PATH {start|stop|restart}"; }
if [ ! -d $1 ]; then usage && exit 1; fi
source "$1/config.sh"

start() { mongod --config $MONGOD_CONF; }
stop() { mongod --config $MONGOD_CONF --shutdown; }

case "$2" in
  start) start ;;
  stop) stop ;;
  restart) stop && start ;;
  *) usage && exit 1 ;;
esac
