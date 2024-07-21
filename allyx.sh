#!/bin/bash

MODULES=("asus-wmi")
UPSTREAM_URL="https://github.com/hhd-dev/ko-test"
LOCAL_DIR="/tmp/ko-git"
set -e

# Cleaning up download dir
echo "# Downloading data to '$LOCAL_DIR'"
rm -rf $LOCAL_DIR
mkdir -p $LOCAL_DIR
git clone $UPSTREAM_URL $LOCAL_DIR

REV=$(git -C $LOCAL_DIR rev-parse --short HEAD)
echo
echo "# Using git version: $REV"

# Removing old modules
echo
echo "# Removing old modules"
for module in "${MODULES[@]}"; do
    echo "- Removing module: '$module'"
    sudo rmmod $module || true
done

# Applying new modules
echo
echo "# Applying new modules"
for module in "${MODULES[@]}"; do
    echo "- Applying module: '$module'"
    sudo insmod $LOCAL_DIR/$module.ko
done