#!/bin/bash

INTERFACE="eno1"

IP_ADDRESS=$(ifconfig $INTERFACE | grep 'inet' | grep 'netmask' | grep 'broadcast' | cut -d' ' -f10)
RESULT=$(dig health.check @${IP_ADDRESS} | grep 169.254.254.254 | wc -l)
if [[ "$RESULT" == "1" ]]; then
  exit 0
fi
exit 1
