#!/bin/bash

. config_base.sh

#############################
# Clean                     #
#############################

# Go to releases directory
cd $RELEASES_DIR

# Clean releases older than 2 days ago (2880 min)
# Credits to someone over the Internet
find . -maxdepth 1 -name "app_20*" -mmin +2880 | head -n 5 | xargs rm -Rf
