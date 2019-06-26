#!/bin/sh

usage()
{
    echo "Usage:"
    echo "    -s | --serial     : Open serial console on /dev/ttyUSB0"
    echo "    -e | --ethernet   : Start ssh connection over Ethernet"
    echo "    -w | --wifi       : Start ssh connection over Wifi"
}

while [ ${#} -gt 0 ]; do
    opt=${1}
    shift

    case "${opt}" in
        -s | --serial)
            minicom -D /dev/ttyUSB0 -c on
            ;;
        -e | --ethernet)
            ssh root@192.168.100.1
            ;;
        -w | --wifi)
            ssh root@192.168.50.1
            ;;
        *)
            usage
            echo "Error: Invalid argument: ${opt}"
            ;;
    esac
done

