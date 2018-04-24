FROM tiredofit/alpine:3.7
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

### Set Environment Variables
  ENV ENABLE_SMTP=FALSE 

### Add Dependencies      
   RUN   set -x ; \
         apk update ; \
         apk add \
             expect \
             lua-ldap \
             openssl \
             prosody \
             sudo \
             ; \

### Grab Prosody Modules
    cd /usr/lib/prosody/modules ; \
    wget https://raw.githubusercontent.com/prosody-modules/mod_lib_ldap/master/ldap.lib.lua ; \
    wget https://raw.githubusercontent.com/prosody-modules/mod_auth_ldap2/master/mod_auth_ldap2.lua ; \
    wget https://raw.githubusercontent.com/prosody-modules/mod_storage_ldap/master/mod_storage_ldap.lua ; \

### Cleanup
    rm -rf /usr/src/* /var/cache/apk/* /tmp/* /var/tmp/*

### Networking Configuration
  EXPOSE 5222 5280 5347

### Add Files
  ADD install /

