<h1 align="center">
  <a href="https://hub.docker.com/r/julianprieber/littlelink-custom"><img src="https://i.imgur.com/5o0w0jk.png" alt="LittleLink Custom"></a>
</h1>

<h3 align="center">Pull, deploy, enjoy!</h3><br>

<p align="center">
  <a href="#1">About</a> •
  <a href="#2">About LittleLink Custom</a> •
  <a href="#3">Pull</a> •
  <a href="#4">Deployment</a> •
  <a href="#5">Updating</a> •
  <a href="#6">Build</a>
</p><br>

<p align="center">
  <strong><a href="https://demo.littlelink-custom.com/">Live Demo</a></strong>
</p>

<p align="center">
<a href="https://github.com/JulianPrieber/llc-docker/stargazers"><img src="https://img.shields.io/github/stars/julianprieber/llc-docker?logo=github&style=flat&logo=appveyor&label=star%20this%20project"></img></a>
<a href="https://hub.docker.com/r/julianprieber/littlelink-custom"><img src="https://img.shields.io/docker/stars/julianprieber/littlelink-custom?&style=flat&logo=appveyor&label=Docker%20hub"></img></a>
<a href="https://discord.littlelink-custom.com"><img src="https://img.shields.io/discord/955765706111193118?color=4A55CC&label=Discord&logo=discord&style=flat&logo=appveyor"></img></a>
<a href="https://github.com/sponsors/julianprieber"><img src="https://img.shields.io/github/sponsors/JulianPrieber?color=BF4B8A&logo=githubsponsors&style=flat&logo=appveyor=Sponsor%20on%20Github"></img></a>
<a href="https://patreon.com/julianprieber"><img src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3Djulianprieber%26type%3Dpatrons&style=flat&logo=appveyor"></img></a>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/julianprieber/littlelink-custom"><img src="https://i.imgur.com/u9W2tg1.png" alt="Docker Hub" width="280" ></a>
</p>

<a name="1"></a>
## About

The official docker version of [LittleLink Custom](https://github.com/JulianPrieber/littlelink-custom). This docker image is a simple to set up solution, containing everything you need to run LittleLink Custom.

The docker version of LittleLink Custom retains all the features and customization options of the [original version](https://github.com/JulianPrieber/littlelink-custom).

This docker is based on [Alpine Linux](https://www.alpinelinux.org/), a Linux distribution designed to be small, simple and secure. The web server is running [Apache2](https://www.apache.org/), a free and open-source cross-platform web server software. The docker comes with [PHP 8.0](https://www.php.net/releases/8.0/en.php) for high compatibility and performance.

#### Using the docker is as simple as pulling and deploying.

<br>

<a name="2"></a>
## About LittleLink Custom

<p align="center">
<img width="450" src="https://i.imgur.com/mtP2K3K.png">
</p>

<p align="center">
<strong>LittleLink Custom is a highly customizable link sharing platform with an intuitive, easy to use user interface.</strong>
    
<p align="center">LittleLink Custom allows you to create a personal profile page. Many social media platforms only allow for one link. With this, you can have all the links you want clickable on one site. Set up your personal site on your own server in a few clicks.</p>
</p>

<br>

<p align="center">
<strong>Learn more about LittleLink Custom, and all the features here:</strong>
</p>

<br>

<p align="center">
  <a href="https://littlelink-custom.com"><img src="https://i.imgur.com/c1PYOs6.png" alt="About" width="310" ></a>
</p>

<br>

<a name="3"></a>
## Pull

`docker pull julianprieber/littlelink-custom`

<br>

<a name="4"></a>
## Deployment

You may change port *80*, *443* to your preferred values.  

Both HTTP and HTTPS are supported and exposed by default.

### Optional environment variables

- `SERVER_ADMIN` (an email, defaults to `you@example.com`)
- `HTTP_SERVER_NAME` (a [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `www.example.com`)
- `HTTPS_SERVER_NAME` (a [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `www.example.com`)
- `LOG_LEVEL` (a [log level](https://httpd.apache.org/docs/2.4/fr/mod/core.html#loglevel), defaults to `info`)
- `TZ` (a [timezone](https://www.php.net/manual/timezones.php), defaults to `UTC`)
- `PHP_MEMORY_LIMIT` (a [memory-limit](https://www.php.net/manual/ini.core.php#ini.memory-limit), defaults to `256M`)

<br>

#### Deploy

<pre>
docker run --detach \
    --name littlelink-custom \
    --publish 80:80 \
    --publish 443:443 \
    --restart unless-stopped \
    julianprieber/littlelink-custom
</pre>

<br>

#### Custom deployment

<pre>
docker run --detach \
    --name littlelink-custom \
    --hostname littlelink-custom \
    --env HTTP_SERVER_NAME="www.example.xyz" \
    --env HTTPS_SERVER_NAME="www.example.xyz" \
    --env SERVER_ADMIN="admin@example.xyz" \
    --env TZ="Europe/Berlin" \
    --env PHP_MEMORY_LIMIT="512M" \
    --publish 80:80 \
    --publish 443:443 \
    --restart unless-stopped \
    julianprieber/littlelink-custom
</pre>

<br>


#### You can now log in to the Admin Panel, on your defined ports, with the credentials:
-   **email:** `admin@admin.com`
-   **password:** `12345678`

<br>	

### Optional configuration:
Optionally, you can change the app name in your ".env" file in the root directory of your LittleLink Custom installation. At the moment this is set to
APP_NAME="LittleLink Custom" you can change "LittleLink Custom" to what ever you like. This setting defines the page title and welcome message.

For more configuration options, refer to the [documentation](https://littlelink-custom.com/docs/d/configuration-getting-started/).

<br>

<a name="5"></a>
## Updating

When a **new version** is released, you will get an update notification on your Admin Panel.

### Automatic one click Updater
This updater allows you to update your installation with just one click.

<br>	

**How to use the Automatic Updater:**

- To update your instance, click on the update notification on your Admin Panel.

- Click on “Update automatically” and the updater will take care of the rest.

<br>

---

<br>

<a name="6"></a>
## Build

**If you wish to build or modify your own docker version of LittleLink Custom, you can do so with the instructions below:**

- Download this GitHub repository as well as the latest release of LittleLink Custom from [here](https://github.com/JulianPrieber/littlelink-custom/releases/latest/download/littlelink-custom.zip).
- Place the downloaded release files directly into the littlelink-custom folder from this repository.

From the docker directory, run the command:
<pre>
docker build -t littlelink-custom .
</pre>

<br>
<br>
