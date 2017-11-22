#!/bin/bash

# Load config; This will add a bunch of variables to the environment
source "$1"

usage() { echo "install-mongodb-local CONFIG_FILE "; }

if [ -z $1 ]; then usage && exit 1; fi;

if [ ! -d "$MONGO_PATH" ]; then mkdir "$MONGO_PATH"; fi;

if [ -d "$MONGO_INSTALL_PATH" ]; then
  echo "MongoDB already installed at $MONGO_INSTALL_PATH"
else
  wget --progress=bar:force "https://fastdl.mongodb.org/linux/$MONGO_VERSION.tgz"
  tar -zxf "$MONGO_VERSION.tgz"
  mv "$MONGO_VERSION" "$MONGO_INSTALL_PATH"

  # Cleanup
  rm $MONGO_VERSION.tgz
fi;

# Copy config file over
cp "$1" "$MONGO_PATH/config.sh"

# Fix repo location in conf file and copy to mongo path
# Ugh
cp "$REPO_PATH/mongod.conf" "$MONGO_PATH/mongod.conf"
sed -i -e "s:%%MONGO_PATH%%:$MONGO_PATH:g" "$MONGO_PATH/mongod.conf"
sed -i -e "s:%%MONGO_DBPATH%%:$MONGO_DBPATH:g" "$MONGO_PATH/mongod.conf"

# Start mongod (will start in the background)
if [ ! -d "$MONGO_DBPATH" ]; then mkdir "$MONGO_DBPATH"; fi
"$REPO_PATH/scripts/start-stop-mongod.sh" "$MONGO_PATH" start

# Setup mongo collections, etc.
mongo $MONGO_DB $REPO_PATH/bootstrap/init_mongo_collections.js