#!/bin/bash
########################################################################
#  _____  _                           _____             _
# |  __ \(_)                         |  __ \           | |
# | |  | |_  __ _ _ __   __ _  ___   | |  | | ___ _ __ | | ___  _   _
# | |  | | |/ _` | '_ \ / _` |/ _ \  | |  | |/ _ \ '_ \| |/ _ \| | | |
# | |__| | | (_| | | | | (_| | (_) | | |__| |  __/ |_) | | (_) | |_| |
# |_____/| |\__,_|_| |_|\__, |\___/  |_____/ \___| .__/|_|\___/ \__, |
#       _/ |             __/ |                   | |             __/ |
#      |__/             |___/                    |_|            |___/
########################################################################

###########################
# Load configurations     #
###########################

. config_base.sh

. config_app.sh

###########################
# Fetch current release   #
###########################

# Current release
CURRENT_RELEASE=$APP_NAME'_'`date +"%Y%m%d%H%M%S"`

# Activate virtualenv
source $VIRTUAL_ENV

# Creates releases dir if not exists
[ -d $RELEASES_DIR ] || mkdir $RELEASES_DIR;

# Change dir to releases dir
cd $RELEASES_DIR;

# Clone
git clone $REPO --branch=$BRANCH --depth=1 $CURRENT_RELEASE;

###########################
# Setup app               #
###########################

# Work on current release dir
cd $RELEASES_DIR$CURRENT_RELEASE

# Install packages
pip install -r requirements.txt

# Test app with production settings
cd $RELEASES_DIR$CURRENT_RELEASE
./manage.py test --settings=$CONFIGURATION
TESTS_RESULT=$?

###########################
# Linking                 #
###########################

# Tests passed
if [[ $TESTS_RESULT -eq 0 ]]; then
  # Migrate production database
  echo 'Migrating...'
  ./manage.py migrate --settings=$CONFIGURATION
  echo 'Migrated.'

  # Collect statics
  ./manage.py collectstatic --noinput

  # Work on Base Dir
  cd $BASE_DIR

  # Drops existing current
  rm $CURRENT_DIR

  # New current
  ln -s $RELEASES_DIR$CURRENT_RELEASE $CURRENT_DIR

  # Reload apache
  sudo service apache2 reload

  echo 'Success!'
else
  echo 'Tests failed!'
fi
