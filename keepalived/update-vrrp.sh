#!/bin/bash

INTERFACE="enp0s3"

IP_ADDRESS=$(/usr/sbin/ifconfig ${INTERFACE} | /usr/bin/grep 'inet' | /usr/bin/grep 'netmask' | /usr/bin/grep 'broadcast' | /usr/bin/cut -d' ' -f10)

# Clear all NAT rules
iptables -t nat -F

# Unbound
VRRP_ADDRESS=10.0.3.201
VRRP_PORT=53
/usr/sbin/iptables -t nat -A PREROUTING -d ${VRRP_ADDRESS}/32 -p udp -m udp --dport ${VRRP_PORT} -j DNAT --to-destination ${IP_ADDRESS}:
/usr/sbin/iptables -t nat -A POSTROUTING -d ${IP_ADDRESS}/32 -p udp -m udp --dport ${VRRP_PORT} -j SNAT --to-source ${VRRP_ADDRESS}

# Sync Changes
rsync --recursive --delete /mnt/vagabond/services/nomad-vrrp/keepalived/* /etc/keepalived/
systemctl restart keepalived.service
