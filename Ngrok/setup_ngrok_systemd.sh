#!/bin/bash
set -xeuo pipefail

sudo cp ngrok.service /etc/systemd/system/ngrok.service

systemctl enable ngrok
systemctl start ngrok
systemctl status ngrok.service
