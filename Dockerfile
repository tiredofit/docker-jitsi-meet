FROM tiredofit/debian:stretch
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Dependencies Install
  RUN curl -ssL https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - && \
      #echo 'deb https://download.jitsi.org/nightly/deb unstable/' >> /etc/apt/sources.list && \
      #echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list && \
      echo 'deb https://download.jitsi.org testing/' >> /etc/apt/sources.list && \
      #curl -ssL https://download.jitsi.org/nightly/deb/unstable/archive.key | apt-key add - && \
      apt-get update && \
      apt-get -y --allow-unauthenticated install \
              dnsutils \
              expect \
              jitsi-meet \
              nginx \
              sudo && \
      apt-get clean && \

      mkdir -p /www/logs && \
      mkdir -p /var/run/prosody && \
      chown -R prosody /var/run/prosody && \
          
### Cleanup
      rm -rf /var/log/prosody/* /var/log/jitsi/* /var/log/nginx/* /var/lib/apt/lists/*

### Add Files
  ADD install /

### Networking Configuration
  EXPOSE 80 443 5347 4443 10000-10020/udp

### Entrypoint Configuration
  ENTRYPOINT ["/init"]
