# rtorrent-flood

Flood is a modern rtorrent client 
![FLOOD UI](https://github.com/Flood-UI/flood/raw/master/flood.png)

## Credits
image based on linuxserver.io/nginx-alpine base image

## Usage


### docker

```
docker run -d \
  --name torrent \
  -v <path/to/downloads>:/downloads \
  -v <path/to/config>:/config \
  -p 80:80 \
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
      - 80:80
      - 49184:49184
      - 49184:49184/udp
    restart: unless-stopped
```

## Parameters

| Parameter | Function |
|:--:|--|
| `-p 80` | Web port (flood and rpc) port |
| `-p 49184` | Bit-torrent port |
| `-p 49184/udp` | Bit-torrent port |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e FLOOD_SECRET=secret` | Flood secret token **required** |
| `-e RTORRENT_PORT="49184-49184"` | Bit-torrent port change port mapping |
| `-e RTORRENT_SOCK=true` | using socket file or scgi port for rtorrent communication |
| `-e RTORRENT_SOCK_PATH=/config/.sessions/rtorrent.sock` | where the socket is located if `RTORRENT_SOCK=true` |
| `-e WEBSERVER_PORT=80` | scgi port to use |

## Service
The flood UI is accessible via ```http://<ip-address>```
The rtorrent RPC is accessible via ```http://<ip-address>/RPC2```

You must configure a reverse proxy (apache, nginx, traefik...) to protect access to RPC2 endpoint.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

