#!/bin/bash

sudo systemctl stop nomad-vrrp.service
sudo systemctl disable nomad-vrrp.service
sudo cp nomad-vrrp.service /lib/systemd/system/
sudo cp nomad-vrrp.sh /usr/local/bin/
sudo systemctl enable nomad-vrrp.service
sudo systemctl start nomad-vrrp.service
