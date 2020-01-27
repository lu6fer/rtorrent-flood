FROM lsiobase/alpine

ENV FLOOD_SECRET=secret \
    RTORRENT_PORT="49184-49184" \
    RTORRENT_SCGI_PORT="5000" \
    RTORRENT_SCGI_HOST="localhost" \
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
    apk del devdep

COPY root /

EXPOSE 3000 5000 49184 49184/udp

VOLUME /config /downloads
