#!/bin/sh

cd /frps

cat <<-EOF > /frps/frps.ini
[common]
bind_port = $PORT
EOF

echo $PORT
/frps/frps -c /frps/frps.ini