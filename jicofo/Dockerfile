FROM tiredofit/alpine:3.7
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

ARG JICOFO_VERSION

### Set Environment Variables
ENV ENABLE_SMTP=FALSE
ENV JICOFO_VERSION=${JICOFO_VERSION:-403}


### Add User
  RUN adduser -h /usr/share/jicofo -D -g "Jitsi Conference Focus" -u 2500 jicofo && \

### Add Dependencies      
      apk update && \
      apk add \
          git \
          maven \
          openjdk8 \
          sudo \
          unzip \
          && \

    mkdir -p /usr/src/jicofo && \
    curl -sSL https://codeload.github.com/jitsi/jicofo/tar.gz/$JICOFO_VERSION | tar xvfz - --strip 1 -C /usr/src/jicofo/ && \
    cd /usr/src/jicofo && \
    mvn package -DskipTests -Dassembly.skipAssembly=false && \
    cd /usr/src/jicofo && \
    unzip ./target/jicofo-linux-x64-1.1-SNAPSHOT.zip && \
    mkdir -p /usr/share/jicofo && \
    cp -R ./jicofo-*/* /usr/share/jicofo && \

### Cleanup    
    apk del \
        git \
        maven \
        openjdk8 \
        unzip \
        && \
   
    apk add \
        openjdk8-jre \
        && \

    rm -rf /root/.m2 /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Networking Configuration
  EXPOSE 5222 5347

### Add Files
  ADD install /
