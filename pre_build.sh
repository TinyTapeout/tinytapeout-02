#!/bin/bash
set -e

# environment
. setuptokens.sh

# unzip gds files
make uncompress

# delete old project dir
rm -rf ./projects/

# fetch designs
./configure.py --clone-all
# update caravel config
./configure.py --update-caravel

echo 'now run: make user_project_wrapper'

