# FRP Heroku

Setup [FRP server on Heroku](#frp-server---heroku) and [Client on Local (Ubuntu currently)](#frp-client---ubuntu). Support [FRP server on Ubuntu](#frp-server---ubuntu) as well and [other alternatives](#alternatives).

**Note**:

**Currently, we need two ports to build communication between frps and frpc, but Heroku don't support self-defined port...**

**Additional sad news. Since November 28, 2022, Heroku no longer offers its users a free tier or free Dynos...**

## Heroku (Skip this currently...)

* [Heroku](https://www.heroku.com/)
  * [Account Verification | Heroku Dev Center](https://devcenter.heroku.com/articles/account-verification)
* [Dashboard](https://dashboard.heroku.com/apps)

### Setup Heroku CLI

* [The Heroku CLI | Heroku Dev Center](https://devcenter.heroku.com/articles/heroku-cli)

```sh
# Install on Ubuntu
sudo snap install --classic heroku

# Check Installation
heroku --version

# Login
heroku login
```

* [Deploying with Git | Heroku Dev Center](https://devcenter.heroku.com/articles/git)

### heroku.yml

* [Building Docker Images with heroku.yml | Heroku Dev Center](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)
* [heroku.yml build manifest is now available (developer preview) | Heroku Dev Center](https://devcenter.heroku.com/changelog-items/1332)

### app.json

* [app.json Schema | Heroku Dev Center](https://devcenter.heroku.com/articles/app-json-schema)

### Deploy Note

IMPORTANT: Heroku dynamically assigns your app a port, so you can't set the port to a fixed number.

* [Why is my Node.js app crashing with an R10 error? - Heroku Help](https://help.heroku.com/P1AVPANS/why-is-my-node-js-app-crashing-with-an-r10-error)
* [Heroku + node.js error (Web process failed to bind to $PORT within 60 seconds of launch) - Stack Overflow](https://stackoverflow.com/questions/15693192/heroku-node-js-error-web-process-failed-to-bind-to-port-within-60-seconds-of)
* [docker - How do I expose ports on Heroku with a Dockerfile? - Stack Overflow](https://stackoverflow.com/questions/44548074/how-do-i-expose-ports-on-heroku-with-a-dockerfile)
* [How do I use the $PORT environment variable in container based apps? - Heroku Help](https://help.heroku.com/PPBPA231/how-do-i-use-the-port-environment-variable-in-container-based-apps)
* [Container Registry & Runtime (Docker Deploys) | Heroku Dev Center](https://devcenter.heroku.com/articles/container-registry-and-runtime)
* [Heroku + node.js: I have a server which uses multiple ports. How can I get Heroku to allocate them? - Stack Overflow](https://stackoverflow.com/questions/37636580/heroku-node-js-i-have-a-server-which-uses-multiple-ports-how-can-i-get-herok)
* [Like Heroku but allows use of two ports? : webdev](https://www.reddit.com/r/webdev/comments/7dfi1y/like_heroku_but_allows_use_of_two_ports/)

Deploy Button

* [Creating a 'Deploy to Heroku' Button | Heroku Dev Center](https://devcenter.heroku.com/articles/heroku-button)

### Dyno

* [Heroku Dynos | Heroku](https://www.heroku.com/dynos)
* [Dynos (app containers) | Heroku Dev Center](https://devcenter.heroku.com/categories/dynos)
  * [Dynos and the Dyno Manager | Heroku Dev Center](https://devcenter.heroku.com/articles/dynos)
  * [Free Dyno Hours | Heroku Dev Center](https://devcenter.heroku.com/articles/free-dyno-hours)
* [Heroku Exec (SSH Tunneling) | Heroku Dev Center](https://devcenter.heroku.com/articles/exec)

### Useful Command

```sh
# View logs
$ heroku logs --tail

# List the dynos for an app
$ heroku ps
Free dyno hours quota remaining this month: 550h 0m (100%)
Free dyno usage for this app: 0h 0m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

# If an app is down, you can restart it (assume it's web.1)
heroku restart web.1
```

## **FRP**

* [fatedier/frp: A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.](https://github.com/fatedier/frp)

### FRP Server - Heroku

> This is the server you want to use as a springboard

```sh
# Create new app
$ heroku create your-server-name
Creating ⬢ your-server-name... done
https://your-server-name.herokuapp.com/ | https://git.heroku.com/your-server-name.git

# Stack the app to `container`
heroku stack:set container
```

```sh
# Check current git remote
git remote -v

# Upload changes to Github
git push origin master
# Upload changes to Heroku
git push heroku master
```

Check the logs to see if the survice is running,
and because Heroku automatically bind the port,
so you may want to check the port so that you can set the `frpc.ini`

```sh
heroku logs --app=your-server-name
```

Server setting

...

> If want to use the docker for Heroku *outside of Heroku*, remember to add `-e PORT=7000` argument and open necessary ports (e.g. 7000, 6000)

### FRP Client - Ubuntu

> This is the computer you want to connect to

```sh
# Setup binary executables
bash get_frp_local.sh
```

Now you should be able to use `frps` and `frpc`.

Change settings in `frpc.ini` to your heroku address.

```sh
# Start client
frpc -c frpc.ini
```

> better run with `tmux`

Setup Systemd Service to Auto Start on Reboot (optional but recommend)

```sh
# Copy configure file and start frpc
bash setup_frp_client_systemd.sh
```

```sh
# Stop service
systemctl stop frpc.service
```

> * [使用 Systemd 设置 frp 开机启动](https://notfound.cn/posts/systemd-frp/)
> * [FRP systemd 启动脚本](https://gist.github.com/ihipop/4dc607caef7c874209521b10d18e35af)
> * [FRP systemd 启动脚本](https://gist.github.com/imleafz/43acdb28af331d085064e3643c97be58)
> * [frp内网穿透（linux）](https://blog.csdn.net/weixin_43800762/article/details/86536093)

### FRP Server - Ubuntu

> This is the server you want to use as a springboard

```sh
cd UbuntuFRPServer
```

#### Using Docker

> ```sh
> # Install docker first (https://gist.github.com/daviddwlee84/9ba69aa231a19be54b6f09ae0d158683#file-install_docker-sh)
> bash install_docker.sh
> ```

```sh
# Build docker image
docker build -t frp .

# Run server
docker run -d -p 7000:7000 -p 6000:6000 -p 7500:7500 frp
```

#### Using Directly

> Assume you already got `frps` binaries, otherwise checkout [here](#frp-client---ubuntu).

```sh
# Start server
frps -c frps.ini
```

> better run with `tmux`

#### Using Systemd Service

```sh
# Copy configure file and start frps
bash setup_frp_server_systemd.sh
```

```sh
# Stop service
systemctl stop frps.service
```

```sh
# After modify /etc/frpc.ini, restart the frpc
systemctl restart frpc.service
```

### FRP Server & Client - Windows

> Make sure you have enable script executing
>
> `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine` (Run as administrator)
>
> And there is potential that Windows thinks the `frp*.exe` is a virus. This is how to configure:
>
> 1. Search "Virus & threat protection"
> 2. Goto "Virus & threat protection settings" and click "Manage settings"
> 3. Goto "Exclusions" and click "Add or remove exclusions"
> 4. Add this folder (i.e. the repository directory) (because sometime it delete `*.zip` right away)
> 5. Add "C:\frp" (default install path of my script)

```powershell
# Setup binary executables & Auto run FRPC at system startup (run as administrator)
./setup_frp_windows.ps1

# Check scheduled jobs
ScheduledJob

# Unregister job
Unregister-ScheduledJob -Name FRPC


# To kill background service (run as administrator)
Get-Process frpc
Stop-Process -Id xx
```

> * [PowerShell脚本开机自启动 - MuJianNanBlog](https://blog.mujiannan.me/Posts/Details/13)

## How to Connect

Connect SSH

```sh
ssh -oPort=6000 username@frp-server-ip-address
# equivalent
ssh -p 6000 username@frp-server-ip-address
```

### FRP Dashboard

If you setup with [FRP Server - Ubuntu](#frp-server---ubuntu)

Go to `http://frp-server-ip-address:7500` and login with `admin` for both account and password.

### FRP Setting

#### HTTP

> must set either `custom_domains` or `subdomain` for *http* or *https* `custom_domains and subdomain should set at least one of them`
> otherwise, you can just use *tcp*

* [How to configure frpc.ini if my VPS without domains? · Issue #1288 · fatedier/frp](https://github.com/fatedier/frp/issues/1288)

Use type `tcp`.

Or set `custom_domains = { server_addr }`.

> * [新手入门 - 详解 frp 内网穿透 frpc.ini 配置 - 思有云 - IOIOX](https://www.ioiox.com/archives/79.html)

## Alternatives

> Expose necessary port without using FRP

### Ngrok

Check out [here](Ngrok).

### Applications

* TeamViewer
* [Hamachi](https://www.vpn.net/)

## Other Related Network Settings

### Port Forwarding

#### netsh

> Works in Windows

```sh
# Add
netsh interface portproxy add v4tov4 listenaddress=localaddress listenport=localport connectaddress=destaddress connectport=destport
# Remove
netsh interface portproxy delete v4tov4 listenaddress=localaddress listenport=localport
```

### INI file

> (TODO) seems frp doesn't support special reference parsing

* [INI file - Wikipedia](https://en.wikipedia.org/wiki/INI_file)
* [configparser — Configuration file parser — Python 3.9.2 documentation](https://docs.python.org/3/library/configparser.html)
* [python - How to read and write INI file with Python3? - Stack Overflow](https://stackoverflow.com/questions/8884188/how-to-read-and-write-ini-file-with-python3)
* [python - Reference variable from another ini section - Stack Overflow](https://stackoverflow.com/questions/25049276/reference-variable-from-another-ini-section/25051295#25051295)
* [ini file - Refer variable from another ini file - Stack Overflow](https://stackoverflow.com/questions/33866444/ini-file-refer-variable-from-another-ini-file)

```py
from configparser import ConfigParser, ExtendedInterpolation

config = ConfigParser(interpolation=ExtendedInterpolation())
config.read('frpc.ini')
config['http']['custom_domains']
```

* [Environment variables can be referenced in the configuration file, using Go's standard format](https://github.com/fatedier/frp#using-environment-variables)
* [go-ini/ini: Package ini provides INI file read and write functionality in Go.](https://github.com/go-ini/ini)
* [Variable reference resolution](https://github.com/gookit/ini#variable-reference-resolution)

## Todo

* [ ] Open port for other services
* [ ] Docker for `frpc`?!
* [ ] Find if there is a way to solve reference problem of `frpc.ini` (& `http` connection as well)

## Resources

### Example

Heroku

* [work-chausat/frp-heroku](https://github.com/work-chausat/frp-heroku)
* [ktownag/frp-heroku](https://github.com/ktownag/frp-heroku)

General

* [【心得】frp內網穿透架設心得(文長,難) @Minecraft 我的世界（當個創世神） 哈啦板 - 巴哈姆特](https://m.gamer.com.tw/forum/Co.php?bsn=18673&snB=834074)

Official

* [通过 SSH 访问内网机器 | frp](https://gofrp.org/docs/examples/ssh/)

### Notes for Alternatives

#### Other Tools for Reverse Proxy / NAT Traversal / Intranet Penetration

> * [NAT traversal - Wikipedia](https://en.wikipedia.org/wiki/NAT_traversal)
> * [Intranet Penetration - Baidu Baike](https://baike.baidu.com/item/%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8F/8597835)

#### Deploy

* [Top 5 Alternatives to Heroku | Back4App Blog](https://blog.back4app.com/heroku-alternatives/)
* [Heroku Alternatives — Top 5 Picks - Brenda Clark - Medium](https://medium.com/@brenda.clark/heroku-alternatives-top-5-picks-9095cef91d91)

### Other

* [Keep file in a Git repo, but don't track changes - Stack Overflow](https://stackoverflow.com/questions/9794931/keep-file-in-a-git-repo-but-dont-track-changes)
* [git - Add ignored file to repo but don't track afterwards - Stack Overflow](https://stackoverflow.com/questions/42579526/add-ignored-file-to-repo-but-dont-track-afterwards/42580327)

```sh
git update-index --assume-unchanged frpc.ini
```
