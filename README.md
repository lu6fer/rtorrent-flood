# rtorrent-flood

Flood is a modern rtorrent client 
![FLOOD UI](https://github.com/Flood-UI/flood/raw/master/flood.png)


## Usage

StackEdit stores your files in your browser, which means all your files are automatically saved locally and are accessible **offline!**

### docker

```
docker run -d \
  --name torrent \
  -v <path/to/downloads>:/downloads \
  -v <path/to/config>:/config \
  -p 3000:3000 \
  -p 5000:5000 \
  -p 49184:49184 \
  -p 49184:49184/udp \
  -e PUID=1000 \
  -e PGID=1000 \
  -e FLOOD_SECRET="floodsecret" \
  --restart unless-stopped \
  rtorrent-flood:latest
  ```
### docker-compose
```
---
version: "2"
services:
  rutorrent:
    image: linuxserver/rutorrent
    container_name: torrent
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - <path/to/downloads>:/config
      - <path/to/config>:/downloads
    ports:
      - 3000:3000
      - 5000:5000
      - 49184:49184
      - 49184:49184/udp
    restart: unless-stopped
```

## Parameters

| Parameter | Function |
|:--:|--|
| `-p 3000` | flood ui port |
| `-p 5000` | scgi port if `RTORRENT_SOCK=false` |
| `-p 49184` | Bit-torrent port |
| `-p 49184/udp` | Bit-torrent port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e FLOOD_SECRET=secret` | Flood secret token **required** |
| `-e RTORRENT_SOCKER=true` | using socket file or scgi port for rtorrent communication |
| `-e RTORRENT_PORT="49184-49184"` | Bit-torrent port change port mapping |
| `-e RTORRENT_SCGI_PORT=5000` | scgi port to use |
| `-e RTORRENT_SCGI_HOST=localhost` | scgi host |
| `-e RTORRENT_SOCK_PATH=/config/.sessions/rtorrent.sock` | where the socket is located if `RTORRENT_SOCK=true` |




## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

