#!/bin/bash

INTERFACE="enp0s3"

HOSTNAME=$(hostname)
IP_ADDRESS=$(/usr/sbin/ifconfig ${INTERFACE} | /usr/bin/grep 'inet' | /usr/bin/grep 'netmask' | /usr/bin/grep 'broadcast' | /usr/bin/cut -d' ' -f10)
SALT="tnbctvavpeowpenvrxatdnjvotamqbkq"
HASH=$(echo "${HOSTNAME},${IP_ADDRESS},${SALT}" | sha256sum | cut -f1 -d' '

while :
do
  if [ -f /mnt/vagabond/services/nomad-vrrp/nodes/$HASH ]; then
    if [ -f /mnt/vagabond/services/nomad-vrrp/update-vrrp.sh ]; then
      /mnt/vagabond/services/nomad-vrrp/update-vrrp.sh
      echo "Ran Update"
    fi
    rm /mnt/vagabond/services/nomad-vrrp/nodes/$HASH
  fi
  sleep 10
done
