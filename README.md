# FRP Heroku

Setup FRP server on Heroku and Client on Local (Ubuntu currently)

## Heroku

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

### Deploy Note

IMPORTANT: Heroku dynamically assigns your app a port, so you can't set the port to a fixed number.

* [Why is my Node.js app crashing with an R10 error? - Heroku Help](https://help.heroku.com/P1AVPANS/why-is-my-node-js-app-crashing-with-an-r10-error)
* [Heroku + node.js error (Web process failed to bind to $PORT within 60 seconds of launch) - Stack Overflow](https://stackoverflow.com/questions/15693192/heroku-node-js-error-web-process-failed-to-bind-to-port-within-60-seconds-of)

## FRP

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

## Usage

Connect SSH

```sh
ssh -oPort=6000 username@heroku-ip-address
```

## Resources

### Example

Heroku

* [work-chausat/frp-heroku](https://github.com/work-chausat/frp-heroku)

General

* [【心得】frp內網穿透架設心得(文長,難) @Minecraft 我的世界（當個創世神） 哈啦板 - 巴哈姆特](https://m.gamer.com.tw/forum/Co.php?bsn=18673&snB=834074)

### Other Tools for Reverse Proxy / NAT Traversal / Intranet Penetration

> * [NAT traversal - Wikipedia](https://en.wikipedia.org/wiki/NAT_traversal)
> * [Intranet Penetration - Baidu Baike](https://baike.baidu.com/item/%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8F/8597835)

### Other

* [Keep file in a Git repo, but don't track changes - Stack Overflow](https://stackoverflow.com/questions/9794931/keep-file-in-a-git-repo-but-dont-track-changes)
* [git - Add ignored file to repo but don't track afterwards - Stack Overflow](https://stackoverflow.com/questions/42579526/add-ignored-file-to-repo-but-dont-track-afterwards/42580327)

```sh
git update-index --assume-unchanged frpc.ini
```
