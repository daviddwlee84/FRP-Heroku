#!/bin/bash
set -xeuo pipefail

sudo cp frpc.service /etc/systemd/system/frpc.service
sudo cp frpc.ini /etc/frpc.ini

systemctl start frpc
systemctl enable frpc
systemctl status frpc.service
