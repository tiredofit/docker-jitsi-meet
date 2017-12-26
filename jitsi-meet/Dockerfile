FROM tiredofit/nodejs:8 
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Set Environment Variables
ENV ENABLE_SMTP=FALSE \
    JITSIMEET_VERSION=2635

### Add User
  RUN adduser -h /app -D -g "Jitsi Meet" -u 2500 jitsi && \

### Add Dependencies
      apk update && \
      apk add \
          git \
          nginx \
          make \
          && \

    curl -sSL https://codeload.github.com/jitsi/jitsi-meet/tar.gz/jitsi-meet_$JITSIMEET_VERSION | tar xvfz - --strip 1 -C /app/ && \
    cd /app && \
    npm install node-sass@latest && \
    npm install && \
    make && \

### Permissions Set
    chown -R jitsi /app && \

### Cleanup
    apk del \
        git \
        make \
        && \
    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Add Files
  ADD install /

### Networking Configuration
  EXPOSE 80 443 5280 5347

### Entrypoint Configuration
  ENTRYPOINT ["/init"]
