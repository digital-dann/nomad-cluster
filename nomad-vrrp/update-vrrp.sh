#!/bin/bash

INTERFACE="eno1"
IP_ADDRESS=$(/usr/sbin/ifconfig ${INTERFACE} | /usr/bin/grep 'inet' | /usr/bin/grep 'netmask' | /usr/bin/grep 'broadcast' | /usr/bin/cut -d' ' -f10)

# Update iptables
if [ -d /mnt/vagabond/services/nomad-vrrp/iptables.d ]; then
  for n in $(echo $(iptables --line-number -t nat -nL | grep DNAT | grep vrrp | cut -d ' ' -f1) | rev); do
    iptables -t nat -D PREROUTING $n
  done
  for n in $(echo $(iptables --line-number -t nat -nL | grep SNAT | grep vrrp | cut -d ' ' -f1) | rev); do
    iptables -t nat -D POSTROUTING $n
  done

  for filename in /mnt/vagabond/services/nomad-vrrp/iptables.d/*.fwd; do
    source $filename
  done
fi

# Update keepalived
if [ -d /mnt/vagabond/services/nomad-vrrp/keepalived.d/ ]; then
  rsync --recursive --delete /mnt/vagabond/services/nomad-vrrp/keepalived.d/* /etc/keepalived/
  systemctl restart keepalived.service
fi
