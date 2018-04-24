FROM tiredofit/debian:stretch
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Set Environment Variables
  ENV ENABLE_SMTP=FALSE


### Add Dependencies      
  RUN set -x ; \
      curl -sSL  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add - ; \
      echo 'deb https://download.jitsi.org unstable/' > /etc/apt/sources.list.d/jitsi-stable.list ; \
      apt-get update ; \
      apt-get -y install \
                 dnsutils \
                 jitsi-videobridge \
                 sudo \
                 ; \

### Cleanup    
    rm -rf /usr/src/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Networking Configuration
  EXPOSE 443 5347 4443 10000-20000/udp

### Add Files
  ADD install /
