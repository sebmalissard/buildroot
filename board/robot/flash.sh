

if [ ! -b "${1}" ]; then
    echo "Invalid argument"
    exit 1
fi

sudo dd if=output/images/sdcard.img of=${1} status=progress
sync
