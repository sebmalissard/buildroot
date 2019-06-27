#!/bin/bash

IP_ROBOT_WIFI=192.168.50.1
IP_ROBOT_ETHERNET=192.168.100.1

ssh_interface="none"
dd_select=0
dd_arg=""
rsync_select=0

usage()
{
    echo "Usage:"
    echo "    -d | --d  <device>   : Flash image to the device with dd"
    echo "    -e | --ethernet      : Use ssh connection over Ethernet"
    echo "    -r | --rync          : Synchronize the rootfs with rsync "
    echo "    -w | --wifi          : Use ssh connection over Wifi"
    echo ""
    echo "Example:"
    echo "    flash.sh -d /dev/mmcblk0"
    echo "    flash.sh -r -e"
    echo "    flash.sh -r -w"
    echo ""
}

dd-method()
{
    if [ ! -b "${1}" ]; then
        usage
        echo "Error: Invalid dd argument"
        exit 1
    fi
    
    sudo dd if=output/images/sdcard.img of=${1} status=progress
    sync
}

rsync-method()
{
    if [ "${ssh_interface}" == "none" ]; then
        usage
        echo "Error: rsync require to select an network interface"
        exit 1
    fi
    
    [ "${ssh_interface}" == "ethernet" ] && IP_ROBOT=${IP_ROBOT_ETHERNET}
    [ "${ssh_interface}" == "wifi" ] && IP_ROBOT=${IP_ROBOT_WIFI}
    
    if [ -d output/images/rootfs ]; then
        rm -r output/images/rootfs
    fi

    mkdir output/images/rootfs
    cd output/images/rootfs

    fakeroot bash <<- EOF
        tar xf ../rootfs.tar
        rsync -av -e "ssh -i ${HOME}/.ssh/id_rsa -oUserKnownHostsFile=$HOME/.ssh/known_hosts" --progress . root@${IP_ROBOT}:/
EOF

    cd -
    rm -r output/images/rootfs
}

while [ ${#} -gt 0 ]; do
    opt=${1}
    shift

    case "${opt}" in
        -d | --d)
            dd_select=1
            dd_arg=${1}
            shift
            ;;
        -e | --ethernet)
            ssh_interface="ethernet"
            ;;
        -r | --rsync)
            rsync_select=1
            ;;
        -w | --wifi)
            ssh_interface="wifi"
            ;;
        *)
            usage
            echo "Error: Invalid argument: ${opt}"
            exit 1
            ;;
    esac
done

if [ ${dd_select:-} = 1 ] && [ ${rsync_select:-} = 1 ]; then
    usage
    echo "Error: Can't use option -d and -r at same time"
    exit 1
fi

if [ ${dd_select:-} = 1 ]; then
    dd-method ${dd_arg}
elif [ ${rsync_select:-} = 1 ]; then
    rsync-method
else
    usage
    exit 1
fi
