#!/bin/bash
set -xeuo pipefail

sudo cp frps.service /etc/systemd/system/frps.service
sudo cp frps.ini /etc/frps.ini

sudo systemctl enable frps
sudo systemctl start frps
sudo systemctl status frps.service
