# Linux Kernel Testing Repository
This repository hosts temporary kernel module fixes for Bazzite while they are being developed.
They can be applied in a running system for testing.

Instructions for how to do replicate this repository will follow.
It boils down to compiling a kernel module using the Fedora kernel headers
the tester is using, and then having them apply the script for this repo,
which will replace the module in their device with this one.