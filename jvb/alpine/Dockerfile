FROM tiredofit/alpine:3.7
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.26-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    wget \
        "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
        -O "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"

ENV LANG=C.UTF-8

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
    cp -R /usr/src/jitsi-videobridge-linux-x64-$JVB_VERSION/* /usr/share/jitsi-videobridge
   
    RUN mkdir -p /usr/src/jvb2 && \
    curl -ssL https://codeload.github.com/jitsi/jitsi-videobridge/tar.gz/$JVB_VERSION | tar xvfz - --strip 1 -C /usr/src/jvb2 && \
    apk add maven openjdk8

### Cleanup    
RUN  apk del unzip
#    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Add Files
  ADD install /

### Networking Configuration
  EXPOSE 443 5347 4443 10000-20000/udp

### Entrypoint Configuration
  ENTRYPOINT ["/init"]

