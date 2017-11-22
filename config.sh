# Config options; stored as bash variables

## Config
# The version of mongo to install
MONGO_VERSION="mongodb-linux-x86_64-3.4.10"
# Where the openlibrary-mongodb-clone repo is
REPO_PATH=/vagrant
# Where to store mongo stuff (mongodb, mongo database will be inside this directory)
MONGO_PATH=/home/ubuntu/mongo
# The name of the database to store Open Library data
MONGO_DB=ol_clone



## Derived variables; these are just for convenience and should not be changed
# Where mongodb itself will be stored
MONGO_INSTALL_PATH="$MONGO_PATH/mongodb"
# Where mongo should store the database contents
MONGO_DBPATH="$MONGO_PATH/data"
# Add mongo stuff to the path for convenience
PATH="$MONGO_INSTALL_PATH/bin:$PATH"
# Options to start/stop this mongod
MONGOD_CONF="$MONGO_PATH/mongod.conf"