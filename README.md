# github.com/tiredofit/docker-jitsi-meet

# Introduction

This is a series of Dockerfiles to build a [Jitsi Meet](meet.jit.si) webRTC conferencing solution.

* Prosody 0.10 - Based on Alpine 3.7
* Jitsi Meet - Based on NodeJS 8.9 + Alpine 3.7
* Jitsi Conference Focus - Stable - Based on Alpine 3.7
* Jitsi Video Bridge - Stable - Based on Debian (Alpine source included, but regularly crashes)
* Works out of the box and supports HOST and NAT modes without any further configuration


# Authors

- [Dave Conroy][https://github.com/tiredofit]

# Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

 - This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and 
optionally the [Let's Encrypt Proxy Companion @ 
https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) in 
order to serve your pages. 

This is a complex series of images and relies on all packages to be working together. You will also need to open ports on your 
firewall (See below).

# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/alpine) and 
is the recommended method of installation.


```bash
docker pull tiredofit/jitsi-meet
docker pull tiredofit/jitsi-prosody
docker pull tiredofit/jitsi-videobridge
docker pull tiredofit/jitsi-jicofo
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working 
[docker-compose.yml](https://github.com/tiredofit/docker-jitsi-meet/blob/master/examples/docker-compose.yml) that can be modified for development or production use. All you will need to do is 
change the `HOST` and `VIRTUAL_HOST,LETSENCRYPT_HOST` variables and the system will automatically generate certificates for you and 
the system will function.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

# Configuration

### Data-Volumes
The following directories are used for configuration and can be mapped for persistent storage.

#### jitsi-prosody
| Directory                           | Description                 |
|-------------------------------------|-----------------------------|
| `/certs`                            | Needed to Automatically Generate Certificates for other containers |

#### jitsi-videobridge
| Directory                           | Description                 |
|-------------------------------------|-----------------------------|
| `/certs`                            | Needed to share certificates between containers for Self Signed variants |

#### jitsi-jicofo
| Directory                           | Description                 |
|-------------------------------------|-----------------------------|
| `/certs`                            | Needed to share certificates between containers for Self Signed variants |

#### jitsi-meet
| Directory                           | Description                 |
|-------------------------------------|-----------------------------|
| `/assets/jitsi-meet`                | Put your custom config.js/interfaceConfig.js in here and it will be added on bootup|


### Environment Variables

Below is the complete list of available options that can be used to customize your installation.

#### jitsi-prosody
| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `HOST`      | Hostname of your server e.g. `meet.example.com` Should be same as all other hostnames |
| `JITSI_VIDEO_PASS` | Jitsi Video Bridge Secret e.g. `secret3` |
| `JICOFO_PASS` | Jitsi Conference Focus Secret e.g. `secret2` |
| `JICOFO_USER_PASS` | Jitsi Conference Focus User Secret e.g. `secret1` |

#### jitsi-videobridge
| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `HOST`      | Hostname of your server e.g. `meet.example.com` Should be same as all other hostnames |
| `PROSODY_HOST`      | Container Name of your prosody server e.g. `prosody`         |
| `JITSI_VIDEO_PASS` | Jitsi Video Bridge Secret e.g. `secret3` |
| `NETWORK_MODE`    | Network Mode `NAT` or `HOST` - Defaults to `NAT` |


#### jitsi-jicofo
| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `HOST`      | Hostname of your server e.g. `meet.example.com` Should be same as all other hostnames |
| `PROSODY_HOST`      | Container Name of your prosody server e.g. `prosody`         |
| `JICOFO_PASS` | Jitsi Conference Focus Secret e.g. `secret2` |
| `JICOFO_USER_PASS` | Jitsi Conference Focus User Secret e.g. `secret1` |

#### jitsi-meet
| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `PROSODY_HOST`      | Container Name of your prosody server e.g. `prosody`         |


### Networking

This set of images relies on network ports being exposed to the outside world.
80, 443 for the initial web proxy (which should already be handled by the `jwilder/nginx-proxy` image) and then you must open port 
`4443` and `10000-10100/udp` to the outside world otherwise you *will* have issues with video or audio.

See below diagram:

````
                           80, 443
               +----------------------------+   |      |
               |                            |   |      |
               | Nginx-Proxy w/ Letsecnrypt |   |      |
               |                            |   |      |
               +----------------------------+   |      |
                   +                            |      |
                   |                            |      |
                   |                            |      |
                   |                            |      |
                   |                            |      |
                   v                            |      |
                  80                            |      |
               +-------+                        |      |
               |       |                        |      |
               | Jitsi |                        |      |
               | Meet  |                        |      |
               +--+-+--+                        |      |
                  | |                           |      |
+------------+    | |    +--------------+       |      |
|            |    | |    |              |       |      |
| jitsi-meet +<---+ +--->+ prosody      |       |      |
|            |files 5280 |              |       |      |
+------------+           +--------------+       v      v
                     5222,5347^    ^5347      4443, 10000-10100
                +--------+    |    |    +-------------+
                |        |    |    |    |             |
                | jicofo +----^    ^----+ videobridge |
                |        |              |             |
                +--------+              +-------------+
````

The following ports are exposed.

#### jitsi-prosody
| Port      | Description  |
|-----------|--------------|
| `5222`    | Prosody Clent Listening Port |
| `5280`    | Prosody Server Listening Port |
| `5347`   | Prosody Components |


#### jitsi-videobridge
| Port      | Description  |
|-----------|--------------|
| `443`    | Jitsi Video Bridge Harvester Port |
| `5347`   | Prosody Components |
| `4443`    | Jitsi Video Bridge Harvester Port  |
| `10000-20000/udp`    | Web RTC / ICE  |

#### jitsi-jicofo
| Port      | Description  |
|-----------|--------------|
| `5222`    | Prosody Client Port |
| `5347`   | Prosody Components |

#### jitsi-meet

| Port      | Description  |
|-----------|--------------|
| `80`    | Nginx Listening Port |
| `5280`   | Prosody Server Listening Port |



# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. jitsi-meet) bash
```

# References

* https://github.com/jitsi/jitsi-meet/blob/master/doc/manual-install.md




