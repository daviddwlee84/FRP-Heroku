# Ngrok (for SSH Tunnel)

## Setup Ngrok CLI

```sh
# Install CLI
bash get_ngrok.sh
```

Goto ngrok dashboard and connect the account (i.e. add authtoken): [Setup - ngrok](https://dashboard.ngrok.com/get-started/setup)

## Setup Config File

Add the following to `~/.ngrok2/ngrok.yml`

> You should found that the authtoken already exist

```yml
region: jp
tunnels:
    davidssh:
        proto: tcp
        addr: 22
    v2ray:
        proto: tcp
        addr: 16823
    vnc:
        porto: tcp
        addr: 5900
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

Sometimes you might need to reload the system daemon if you update the settings.

```sh
systemctl daemon-reload
```

## Two Ngrok

1. Signup New account
2. Create another config file, like `~/.ngrok2/ngrok-another.yml`

    ```yml
    authtoken: YOUR_TOKEN
    region: jp
    tunnels:
        vnc:
            proto: tcp
            addr: 5900
        jupyter:
            proto: https
            addr: 8888
    ```

3. Run the config file: `ngrok start --all --config="/home/username/.ngrok2/ngrok-another.yml"`

* [networking - How do I use multiple ngrok accounts on the same workstation? - Stack Overflow](https://stackoverflow.com/questions/43579711/how-do-i-use-multiple-ngrok-accounts-on-the-same-workstation)

## Resources

* [vincenthsu/systemd-ngrok: Automatically start ngrok by systemd](https://github.com/vincenthsu/systemd-ngrok)
