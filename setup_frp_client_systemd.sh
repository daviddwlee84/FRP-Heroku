#!/bin/bash
set -xeuo pipefail

sudo cp frpc.service /etc/systemd/system/frpc.service
sudo cp frpc.ini /etc/frpc.ini

systemctl enable frpc
systemctl start frpc
systemctl status frpc.service
