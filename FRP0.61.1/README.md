
Server

```bash
cd server
docker build -t frp .

# 7000 is for bindAddr
# 7500 is for dashboard
# 6000 and more are for client remoteAddr
docker run -p 17000:7000 -p 17500:7500 -p 16000:6000 frp
```
