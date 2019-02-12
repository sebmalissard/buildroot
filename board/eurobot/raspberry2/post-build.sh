#!/bin/sh

set -u
set -e

# Enable autologin on serial
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^console::respawn:-/bin/login -f root' ${TARGET_DIR}/etc/inittab || \
	sed -i 's|console::respawn*|console::respawn:-/bin/login -f root # GENERIC_SERIAL|' ${TARGET_DIR}/etc/inittab
fi
