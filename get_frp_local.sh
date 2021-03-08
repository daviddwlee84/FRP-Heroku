#!/bin/bash

FRP_VERSION=0.35.1
FRP_NAME=frp_${FRP_VERSION}_linux_amd64
BIN_LOCATION=/usr/local/bin
wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FRP_NAME}.tar.gz
tar xzf ${FRP_NAME}.tar.gz
sudo mv ${FRP_NAME}/frpc ${FRP_NAME}/frps ${BIN_LOCATION}
rm -rf ${FRP_NAME}*
