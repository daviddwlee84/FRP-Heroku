#!/bin/sh


# Dynamic set frps.ini based on PORT
cd /frps
cat <<-EOF > /frps/frps.ini
[common]
bind_port = $PORT
EOF

echo "Running FRP Server :D"
echo "Binding on the port $PORT"
/frps/frps -c /frps/frps.ini