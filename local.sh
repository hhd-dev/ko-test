#!/bin/bash

DISABLE_MODULES=("asus-nb-wmi" "asus-bios" "asus-wmi")
CHANGED_MODULES=("asus-wmi")
CHILD_MODULES=("asus-nb-wmi" "asus-bios")

LOCAL_DIR="/tmp/ko-git"
set -e

# Removing old modules
echo
echo "# Removing old modules"
for module in "${DISABLE_MODULES[@]}"; do
    echo "- Removing module: '$module'"
    sudo rmmod $module || true
done

# Applying new modules
echo
echo "# Applying new modules"
for module in "${CHANGED_MODULES[@]}"; do
    echo "- Applying patched module: '$module'"
    sudo insmod $LOCAL_DIR/$module.ko
done

# Applying new modules
echo
echo "# Applying new modules"
for module in "${CHILD_MODULES[@]}"; do
    echo "- Re-enabling module: '$module'"
    sudo modprobe $module
done