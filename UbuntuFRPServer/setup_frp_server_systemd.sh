#!/bin/bash
set -xeuo pipefail

sudo cp frps.service /etc/systemd/system/frps.service
sudo cp frps.ini /etc/frps.ini

systemctl enable frps
systemctl start frps
systemctl status frps.service
