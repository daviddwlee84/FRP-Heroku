# Ngrok (for SSH Tunnel)

## Setup Ngrok CLI

```sh
# Install CLI
bash get_ngrok.sh
```

Goto ngrok dashboard and connect the account (i.e. add authtoken): [Setup - ngrok](https://dashboard.ngrok.com/get-started/setup)

## Setup Config File

Add the following to `~/.ngrok2/ngrok.yml`

```yml
region: jp
tunnels:
    davidssh:
        proto: tcp
        addr: 22
    v2ray:
        proto: tcp
        addr: 16823
```

## Start Ngrok

```sh
ngrok start davidssh
```

And you can see the status on the dashboard: [Tunnels Online - ngrok](https://dashboard.ngrok.com/status/tunnels)

You should be able to connect to ssh with the given URL and Port like this

```sh
ssh username@0.tcp.jp.ngrok.io -p given_port
```

## Auto Start

```sh
setup_ngrok_systemd.sh
```

* [tunnel - How to keep ngrok running even when signing off of a server - Stack Overflow](https://stackoverflow.com/questions/50681671/how-to-keep-ngrok-running-even-when-signing-off-of-a-server)
