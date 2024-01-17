#!/bin/bash

INTERFACE="eno1"

IP_ADDRESS=$(ifconfig $INTERFACE | grep 'inet' | grep 'netmask' | grep 'broadcast' | cut -d' ' -f10)
RESULT=$(dig adguard.service.consul @169.254.254.254 -p 8600 | "^adguard.service.consul." | cut -d$'\t' -f5)
if [[ "$RESULT" == "$IP_ADDRESS" ]]; then
  exit 0
fi
exit 1
