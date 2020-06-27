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

## Server - Heroku

## FRP

* [fatedier/frp: A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.](https://github.com/fatedier/frp)

### FRP Server - Heroku

```sh
$ heroku create david-frp-server
Creating ⬢ david-frp-server... done
https://david-frp-server.herokuapp.com/ | https://git.heroku.com/david-frp-server.git
```

```sh
# Check current git remote
git remote -v

# Upload changes to Github
git push origin
# Upload changes to heroku
git push heroku
```

### FRP Client - Ubuntu

## Resources

### Example

Heroku

* [work-chausat/frp-heroku](https://github.com/work-chausat/frp-heroku)

General

* [【心得】frp內網穿透架設心得(文長,難) @Minecraft 我的世界（當個創世神） 哈啦板 - 巴哈姆特](https://m.gamer.com.tw/forum/Co.php?bsn=18673&snB=834074)

### Other Tools for Reverse Proxy / NAT Traversal / Intranet Penetration

> * [NAT traversal - Wikipedia](https://en.wikipedia.org/wiki/NAT_traversal)
> * [Intranet Penetration - Baidu Baike](https://baike.baidu.com/item/%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8F/8597835)
