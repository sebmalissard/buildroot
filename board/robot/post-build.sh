#!/bin/sh

set -u
set -e

# Add logging of init.d
if [ -e ${TARGET_DIR}/etc/init.d/rcS ]; then
    grep -qE '^#!/bin/bash' ${TARGET_DIR}/etc/init.d/rcS ||
    sed -i "1s|.*|\
#!/bin/bash\n\
# Log all init.d messages in /var/log/messages\n\
exec 1> >(logger -s -t $(basename \$0)) 2>\&1\
    |" ${TARGET_DIR}/etc/init.d/rcS
fi


echo "root=/dev/mmcblk0p2 rootwait console=tty1" > ${BINARIES_DIR}/rpi-firmware/cmdline.txt
