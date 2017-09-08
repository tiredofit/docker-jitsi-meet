FROM tiredofit/debian:jessie
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"


### Dependencies Install
  RUN apt-get update && \
      echo 'deb http://download.jitsi.org stable/' >> /etc/apt/sources.list && \
      curl https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
      apt-get update && \
      apt-get -y install \
              expect \
              jitsi-meet \
              sudo && \
      apt-get clean && \      

### Logs  Installation
      mkdir -p /www/logs && \
          
### Cleanup
       rm -rf /var/log/prosody/* /var/log/jitsi/* /var/log/nginx/* /var/lib/apt/lists/*

### Networking Configuration
  EXPOSE 80 443 5347 4443 10000-10020/udp

### Entrypoint Configuration
  ENTRYPOINT ["/init"]

