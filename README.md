# [See on Docker Hub](https://hub.docker.com/r/julianprieber/littlelink-custom)

Based on Alpine Linux and running Apache2 with PHP 8.

## Optional environment variables

- `SERVER_ADMIN` (an email, defaults to `you@example.com`)
- `HTTP_SERVER_NAME` (a [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `www.example.com`)
- `HTTPS_SERVER_NAME` (a [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `www.example.com`)
- `LOG_LEVEL` (a [log level](https://httpd.apache.org/docs/2.4/fr/mod/core.html#loglevel), defaults to `info`)
- `TZ` (a [timezone](https://www.php.net/manual/timezones.php), defaults to `UTC`)
- `PHP_MEMORY_LIMIT` (a [memory-limit](https://www.php.net/manual/ini.core.php#ini.memory-limit), defaults to `256M`)

### Pull

`docker pull julianprieber/littlelink-custom`

### Deployment

Change port *80*, *443* to your preferred values.  

Both HTTP and HTTPS are supported and exposed by default.

#### Deploy

<pre>
docker run --detach \
    --name littlelink-custom \
    --publish 80:80 \
    --publish 443:443 \
    --restart unless-stopped \
    julianprieber/littlelink-custom
</pre>

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

See [LittleLink Custom](https://github.com/JulianPrieber/littlelink-custom)

<br>
<br>

---

<br>

### Build

Download this GitHub repository as well as the latest release of LittleLink Custom from [here](https://github.com/JulianPrieber/littlelink-custom/releases/latest/download/littlelink-custom.zip).
Place the downloaded release files directly into the littlelink-custom folder from this repository.

From the docker directory, run the command:
<pre>
docker build -t littlelink-custom .
</pre>


