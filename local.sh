#!/bin/bash

LOCAL_DIR="/tmp/ko-git"
CHANGED_MODULES=$(find $LOCAL_DIR -name "*.ko")
CHILD_MODULES=()
DISABLE_MODULES=( "$CHANGED_MODULES[@]" "$CHILD_MODULES[@]" )

set -e

# Removing old modules
echo
echo "# Removing old modules"
for module in "${DISABLE_MODULES[@]}"; do
    echo "- Removing module: '$module'"
    sudo rmmod $(basename $module) || true
done

# Applying new modules
echo
echo "# Applying new modules"
for module in "${CHANGED_MODULES[@]}"; do
    echo "- Applying patched module: '$module'"
    sudo insmod $LOCAL_DIR/$module
done

# Applying new modules
echo
echo "# Reloading dependent modules"
for module in "${CHILD_MODULES[@]}"; do
    echo "- Re-enabling module: '$module'"
    sudo modprobe $(basename $module)
done