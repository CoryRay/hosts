#!/bin/bash
### Swap between adblocked hosts
### and empty hosts file

set -o errexit
set -o nounset

# we must be root in order to modify the contents of /etc
rootcheck() {
    if [[ $UID -ne 0 ]]; then
        echo "Please run this script as root"
        exit 1
    fi
}
rootcheck

# if the hosts is adblocked one
if [[ $(cat /etc/hosts | wc -l) -gt 10 ]]; then
    # back up current hosts
    mv /etc/hosts /etc/hosts.bak

    # only have the bare necessities
    echo "# empty hosts
127.0.0.1 localhost
127.0.0.1 $HOSTNAME" | cat >> /etc/hosts

else
    # the 'swap' part, move backup to normal
    mv /etc/hosts.bak /etc/hosts
fi
