#!/bin/bash
usage() { echo "$0 MONGO_PATH {authors|works|editions}..."; }
if [ ! -d $1 ] || [ -z $2 ]; then usage && exit 1; fi;
source "$1/config.sh"

DUMP_FILE=ol_dump_authors_latest.txt.gz
DUMPS=$2
IMPORT_INSERTION_WORKERS=2

# Restart Mongo, disabling some features to make importing faster
mongod --config $MONGOD_CONF --shutdown
mongod --config $MONGOD_CONF --nojournal

# Download the dump files
for dump in $DUMPS; do
  DUMP_FILE=ol_dump_${dump}_latest.txt.gz
  if [ -f $DUMP_FILE ]; then
    echo "$DUMP_FILE already exists in this directory; using it instead of downloading"
  else
    wget https://openlibrary.org/data/$DUMP_FILE
  fi

  # Import documents in the JSON file
  gzip -dc $DUMP_FILE | cut -f5 | mongoimport -d $MONGO_DB -c $dump --mode upsert --upsertFields "key" --numInsertionWorkers $IMPORT_INSERTION_WORKERS

  # Cleanup
  rm $DUMP_FILE
done

# Restart mongo normally
"$REPO_PATH/scripts/start-stop-mongod.sh" "$1" restart