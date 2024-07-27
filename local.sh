#!/bin/bash

# Find changed modules
LOCAL_DIR="/tmp/ko-git"
CHANGED_MODULES=($(find $LOCAL_DIR -name "*.ko"))
if [ -z "$CHANGED_MODULES" ]; then
    echo "No modules found in '$LOCAL_DIR'"
    exit 1
fi
CHANGED_MODULE_NAMES=($(basename -a ${CHANGED_MODULES[@]%.ko}))

# In case those modules have dependents, handle them manually as well
# CHILD_MODULES=("asus-wmi")
if [ -z "$CHILD_MODULES" ]; then
    DISABLE_MODULES=("${CHANGED_MODULE_NAMES[@]}")
else
    DISABLE_MODULES=( "${CHILD_MODULES[@]}" "${CHANGED_MODULE_NAMES[@]}" )
fi

set -e

#
# Begin swap
#

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
    sudo insmod $module
done

if [ -z "$CHILD_MODULES" ]; then
    exit 0
fi

# Applying new modules
echo
echo "# Reloading dependent modules"
for module in "${CHILD_MODULES[@]}"; do
    echo "- Re-enabling module: '$module'"
    sudo modprobe $(basename $module)
done