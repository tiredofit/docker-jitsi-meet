FROM tiredofit/alpine:3.7
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Set Environment Variables
  ENV JVB_VERSION=1011

### Add User
  RUN adduser -h /usr/share/jitsi-videobridge -D -g "Jitsi Videobridge" -u 2500 jvb && \

### Add Dependencies      
      apk update && \
      apk add \
          bind-tools \
          openjdk8-jre \
          sudo \
          unzip \
          && \

    cd /usr/src/ &&\
    wget https://download.jitsi.org/jitsi-videobridge/linux/jitsi-videobridge-linux-x64-$JVB_VERSION.zip && \
    mkdir -p /usr/share/jitsi-videobridge && \
    unzip -d . jitsi-videobridge-linux-x64-$JVB_VERSION.zip && \
    cp -R /usr/src/jitsi-videobridge-linux-x64-$JVB_VERSION/* /usr/share/jitsi-videobridge && \
   
### Cleanup    
    apk del unzip && \
    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Add Files
  ADD install /

### Networking Configuration
  EXPOSE 443 5347 4443 10000-20000/udp

### Entrypoint Configuration
  ENTRYPOINT ["/init"]

