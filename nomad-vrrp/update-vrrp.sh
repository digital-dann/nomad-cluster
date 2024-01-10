#!/bin/bash

# Update keepalived
if [ -d /mnt/vagabond/services/nomad-vrrp/keepalived.d/ ]; then
  rsync --recursive --delete /mnt/vagabond/services/nomad-vrrp/keepalived.d/* /etc/keepalived/
  systemctl restart keepalived.service
fi
