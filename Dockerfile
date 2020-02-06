FROM lsiobase/nginx:3.11

ENV WEBSERVER_PORT="80" \
    FLOOD_SECRET="secret" \
    RPC_USER="admin" \
    RPC_PASSWORD="rtorrentadmin" \
    RTORRENT_PORT="49184-49184" \
    RTORRENT_SOCK_PATH="/config/.sessions/rtorrent.sock" \
    RTORRENT_SOCK="true"


RUN apk add --no-cache --upgrade \
      rtorrent \
      npm \
      mediainfo \
      curl \
      unrar \
      su-exec \
      zip && \
    apk add --no-cache --virtual=devdep \
      git && \
    git clone https://github.com/Flood-UI/flood.git /app/flood && \
    cd /app/flood && \
    npm install && \
    cp /app/flood/config.docker.js /app/flood/config.js && \
    npm run build && \
    chown -R abc:abc /app/flood && \
    apk del devdep

COPY root /

LABEL maintainer="lu6fer"
LABEL project_url="https://github.com/lu6fer/rtorrent-flood"

EXPOSE 80 49184 49184/udp

VOLUME /config /downloads
