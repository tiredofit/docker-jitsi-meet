FROM mhart/alpine-node:10
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

ARG JITSIMEET_VERSION

### Set Environment Variables
ENV ENABLE_SMTP=FALSE
ENV JITSIMEET_VERSION=${JITSIMEET_VERSION:-2993}

### Add User
  RUN set -x ; \
      adduser -h /app -D -g "Jitsi Meet" -u 2500 jitsi ; \

### Add Dependencies
      apk update ; \
      apk add \
          git \
          nginx \
          make \
          ; \

### Fetch Jitsi Meet
    git clone https://github.com/jitsi/jitsi-meet --branch ${JITSIMEET_VERSION} /app/ ; \
    cd /app ; \
### Install
    npm install node-sass@latest \
    npm install ; \
    make ; \

### Permissions Set
    chown -R jitsi /app ; \

### Cleanup
    apk del \
        git \
        make \
        ; \

    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Networking Configuration
  EXPOSE 80 443 5280 5347

### Add Files
  ADD install /
