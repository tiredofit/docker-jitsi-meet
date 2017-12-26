FROM tiredofit/alpine:3.7
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Set Environment Variables
  ENV ENABLE_SMTP=FALSE 

### Add Dependencies      
   RUN   apk update && \
         apk add \
             expect \
             openssl \
             prosody \
             sudo \
             && \

    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Add Files
  ADD install /

### Networking Configuration
  EXPOSE 5222 5280 5347

### Entrypoint Configuration
  ENTRYPOINT ["/init"]
