#!/bin/bash

UPSTREAM_URL="https://github.com/hhd-dev/ko-test"
LOCAL_DIR="/tmp/ko-git"
set -e

# Cleaning up download dir
echo "# Downloading data to '$LOCAL_DIR'"
rm -rf $LOCAL_DIR
mkdir -p $LOCAL_DIR
git clone --depth=1 $UPSTREAM_URL $LOCAL_DIR

REV=$(git -C $LOCAL_DIR rev-parse --short HEAD)
NAME=$(git -C $LOCAL_DIR rev-list --max-count=1 --no-commit-header --format=%B HEAD)
echo
echo "# System Information"
echo "Kernel version: $(uname -r)"
echo "Repo ($REV): $NAME"

echo
echo "# Switching over to local script"
exec $LOCAL_DIR/local.sh