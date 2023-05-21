<p align="center">
  <img width="200px" src="https://raw.githubusercontent.com/LinkStackOrg/branding/main/logo/svg/logo_animated.svg"><br>
  <picture>
    <source media="(prefers-color-scheme: dark)" width="400px" srcset="https://raw.githubusercontent.com/LinkStackOrg/branding/main/badges/png/website_light.png">
    <img width="400px" src="https://raw.githubusercontent.com/LinkStackOrg/branding/main/badges/png/website_dark.png">
  </picture>
</p>
  
<h3 align="center">Docker Edition</h3><br>
<h4 align="center">Pull, deploy, enjoy!</h3><br>

<p align="center">
  <a href="#1">About</a> •
  <a href="#2">About LinkStack</a> •
  <a href="#3">Pull</a> •
  <a href="#4">Supported Architectures</a> •
  <a href="#5">Deployment</a> •
  <a href="#6">Updating</a> •
  <a href="#7">Build</a> •
  <a href="#8">Persistent storage</a> •
  <a href="#9">Reverse Proxy</a>
</p><br>

<p align="center">
  <strong><a href="https://linksta.cc">Live Demo</a></strong>
</p>

<p align="center">
<a href="https://github.com/linkstackorg/linkstack-docker/stargazers"><img src="https://img.shields.io/github/stars/linkstackorg/linkstack-docker?logo=github&style=flat&logo=appveyor&label=star%20this%20project"></img></a>
<a href="https://discord.linkstack.com"><img src="https://img.shields.io/discord/955765706111193118?color=4A55CC&label=Discord&logo=discord&style=flat&logo=appveyor"></img></a>
<a href="https://github.com/sponsors/linkstackorg"><img src="https://img.shields.io/github/sponsors/julianprieber?color=BF4B8A&logo=githubsponsors&style=flat&logo=appveyor=Sponsor%20on%20Github"></img></a>
<a href="https://patreon.com/julianprieber"><img src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Djulianprieber%26type%3Dpatrons&style=flat&logo=appveyor"></img></a>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/linkstackorg/linkstack"><img src="https://raw.githubusercontent.com/LinkStackOrg/branding/main/badges/png/docker-hub.png" alt="Docker Hub" width="280" ></a>
</p>

<a name="1"></a>
## About

The official docker version of [LinkStack](https://github.com/linkstackorg/linkstack). This docker image is a simple to set up solution, containing everything you need to run LinkStack.

The docker version of LinkStack retains all the features and customization options of the [original version](https://github.com/linkstackorg/linkstack).

This docker is based on [Alpine Linux](https://www.alpinelinux.org/), a Linux distribution designed to be small, simple and secure. The web server is running [Apache2](https://www.apache.org/), a free and open-source cross-platform web server software. The docker comes with [PHP 8.0](https://www.php.net/releases/8.0/en.php) for high compatibility and performance.

#### Using the docker is as simple as pulling and deploying.

<br>

<a name="2"></a>
## About LinkStack

<p align="center">
<a href="https://github.com/linkstackorg/linkstack-docker">
<picture>
  <source media="(prefers-color-scheme: dark)" width="600px" srcset="https://raw.githubusercontent.com/LinkStackOrg/branding/main/marketing/docker_edition_dark.png">
  <img width="600px" src="https://raw.githubusercontent.com/LinkStackOrg/branding/main/marketing/docker_edition_light.png">
</picture>
</a>
</p>

<p align="center">
<strong>LinkStack is a highly customizable link sharing platform with an intuitive, easy to use user interface.</strong>
    
<p align="center">LinkStack allows you to create a personal profile page. Many social media platforms only allow for one link. With this, you can have all the links you want clickable on one site. Set up your personal site on your own server in a few clicks.</p>
</p>

<br>

<p align="center">
<strong>Learn more about LinkStack, and all the features here:</strong>
</p>

<br>

<p align="center">
  <a href="https://github.com/linkstackorg/linkstack">About LinkStack</a>
</p>

<br>

<a name="3"></a>
## Pull

```shell
docker pull linkstackorg/linkstack
```

<br>

<i>Alternative mirror:</i>

```shell
docker pull ghcr.io/linkstackorg/linkstack
```

<br>

<a name="4"></a>
## Supported Architectures

- [`linux/amd64`](https://hub.docker.com/r/linkstackorg/linkstack/tags)
- [`linux/arm/v6`](https://hub.docker.com/r/linkstackorg/linkstack/tags)
- [`linux/arm/v7`](https://hub.docker.com/r/linkstackorg/linkstack/tags)
- [`linux/arm64`](https://hub.docker.com/r/linkstackorg/linkstack/tags)

<br>

<a name="5"></a>
## Deployment

You may change port *80*, *443* to your preferred values.  

Both HTTP and HTTPS are supported and exposed by default.

### Optional environment variables

- `SERVER_ADMIN` (the email, defaults to `you@example.com`)
- `HTTP_SERVER_NAME` (the [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `localhost`)
- `HTTPS_SERVER_NAME` (the [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `localhost`)
- `LOG_LEVEL` (the [log level](https://httpd.apache.org/docs/2.4/fr/mod/core.html#loglevel), defaults to `info`)
- `TZ` (the [timezone](https://www.php.net/manual/timezones.php), defaults to `UTC`)
- `PHP_MEMORY_LIMIT` (the [memory-limit](https://www.php.net/manual/ini.core.php#ini.memory-limit), defaults to `256M`)
- `UPLOAD_MAX_FILESIZE` (the [upload_max_filesize](https://www.php.net/manual/en/ini.core.php#ini.upload-max-filesize), defaults to `8M`)

<br>

#### Deploy

<a href="#deploy"><img width="350" src="https://img.shields.io/badge/-We%20recommend%20setting%20up%20persistent%20storage-yellow"></a><br>
<a href="#8"><i>Read more about persistent storage</i></a>

<br>

**Create a new volume:**
<pre>docker volume create linkstack</pre>

<br>

<pre>
docker run --detach \
    --name linkstack \
    --publish 80:80 \
    --publish 443:443 \
    --restart unless-stopped \
    --mount source=linkstack,target=/htdocs \
    linkstackorg/linkstack
</pre>

<br>

#### Custom deployment

<pre>
docker run --detach \
    --name linkstack \
    --hostname linkstack \
    --env HTTP_SERVER_NAME="www.example.xyz" \
    --env HTTPS_SERVER_NAME="www.example.xyz" \
    --env SERVER_ADMIN="admin@example.xyz" \
    --env TZ="Europe/Berlin" \
    --env PHP_MEMORY_LIMIT="512M" \
    --env UPLOAD_MAX_FILESIZE="16M" \
    --publish 80:80 \
    --publish 443:443 \
    --restart unless-stopped \
    --mount source=linkstack,target=/htdocs \
    linkstackorg/linkstack
</pre>

<br>

#### Docker Compose
<ins>Use HTTPS for your reverse proxy to avoid issues</ins><br>
Example config.

<pre>
version: "3.8"

services:

  linkstack:
    hostname: 'linkstack'
    image: 'linkstackorg/linkstack:latest'
    environment:
      TZ: 'Europe/Berlin'
      SERVER_ADMIN: 'admin@example.com'
      HTTP_SERVER_NAME: 'example.com'
      HTTPS_SERVER_NAME: 'example.com'
      LOG_LEVEL: 'info'
      PHP_MEMORY_LIMIT: '256M'
      UPLOAD_MAX_FILESIZE: '8M'
    volumes:
      - 'linkstack_data:/htdocs'
    ports:
      - '8190:443'
    restart: unless-stopped

volumes:
  linkstack_data:
</pre>

<br>

<a name="6"></a>
## Updating

When a **new version** is released, you will get an update notification on your Admin Panel.

### Automatic one click Updater
This updater allows you to update your installation with just one click.

<br>	

**How to use the Automatic Updater:**

- To update your instance, click on the update notification on your Admin Panel.

- Click on “Update automatically” and the updater will take care of the rest.

<br>

<a name="7"></a>
## Build

**If you wish to build or modify your own docker version of LinkStack, you can do so with the instructions below:**

- Download this GitHub repository as well as the latest release of LinkStack from [here](https://github.com/linkstackorg/linkstack/releases/latest/download/linkstack.zip).
- Place the downloaded release files directly into the linkstack folder from [this repository](https://github.com/linkstackorg/linkstack-docker/archive/refs/heads/main.zip).

From the docker directory, run the command:
<pre>
docker build -t linkstack .
</pre>You can now set up your application on your defined ports.

<br>

<a name="8"></a>
## Persistent storage

Persistent storage for docker containers is storage that is **not** lost when the container is stopped or removed.

This is advantageous since it means that data may be saved even if the container is removed. This is especially crucial when dealing with data that must be retained throughout restarts, such as a database.


All files important to run LinkStack are stored in the "htdocs" folder found in the root directory of your docker container.

We recommend mounting that entire folder to an external volume.

<br>

**However, some user may prefer to preserve only individual files.** <br>
_Expand the details section below to read more about this:_

<details>
If you wish to save only selective files, you may save the following files and folders:

```
/htdocs/.env
/htdocs/database/database.sqlite
/htdocs/config/advanced-config.php
/htdocs/assets/linkstack/images/avatar.png
/htdocs/themes (folder)
/htdocs/assets/img (folder)
```

**This might change with future releases.**
</details>

<br>

<a name="9"></a>
## Reverse Proxy

### NGINX:

**Below is an example NGINX setup for a reverse proxy.**<br>
<ins>Make sure to use HTTPS to access your container to avoid mixed content errors</ins>
<pre>

server {
  listen        443 ssl;
  listen        [::]:443 ssl;
  listen        80;
  listen        [::]:80;
  server_name   your.domain.name;

  location / {
    # Replace with the IP address and port number of your Docker container.
    proxy_pass                          https://127.0.0.1:443;
    proxy_set_header Host               $host;
    proxy_set_header X-Real-IP          $remote_addr;

    proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto  https;
    proxy_set_header X-VerifiedViaNginx yes;
    proxy_read_timeout                  60;
    proxy_connect_timeout               60;
    proxy_redirect                      off;

    # Specific for websockets: force the use of HTTP/1.1 and set the Upgrade header
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_cache_bypass $http_upgrade;
    proxy_set_header X-Forwarded-Proto $scheme;
    
    # Fixes Mixed Content errors.
    add_header 'Content-Security-Policy' 'upgrade-insecure-requests';
  }
}

</pre>

<br>
<br>
