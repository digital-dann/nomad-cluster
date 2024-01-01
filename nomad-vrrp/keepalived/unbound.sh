#!/bin/bash

INTERFACE="enp0s3"

IP_ADDRESS=$(ifconfig $INTERFACE | grep 'inet' | grep 'netmask' | grep 'broadcast' | cut -d' ' -f10)
RESULT=$(dig -t TXT health.check @${IP_ADDRESS} | grep abcdefghijklmnopqrstuvwxyz | wc -l)
if [[ "$RESULT" == "1" ]]; then
  echo "0"
  exit 0
fi
echo "1"
exit 1
