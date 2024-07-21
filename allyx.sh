#!/bin/bash

MODULES=("asus-wmi")
UPSTREAM_URL="https://github.com/hhd-dev/ko-git"
set -e

# Cleaning up download dir
rm -rf /tmp/ko-git
mkdir -p /tmp/ko-git
git clone $UPSTREAM_URL /tmp/ko-git

# Removing old modules
for module in "${MODULES[@]}"; do
    echo "Removing module '$module'"
    sudo rmmod $module || true
done

# Applying new modules
for module in "${MODULES[@]}"; do
    echo "Applying module '$module'"
    sudo insmod /tmp/ko-git/$module.ko
done