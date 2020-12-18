#!/bin/bash
set -xeuo pipefail

sudo cp frpc.service /etc/systemd/system/frpc.service
sudo cp frpc.ini /etc/frpc.ini

sudo systemctl enable frpc
sudo systemctl start frpc
sudo systemctl status frpc.service
