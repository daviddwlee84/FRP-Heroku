#!/bin/bash
set -xeuo pipefail

sudo cp ngrok.service /etc/systemd/system/ngrok.service

systemctl start ngrok
systemctl enable ngrok
systemctl status ngrok.service
