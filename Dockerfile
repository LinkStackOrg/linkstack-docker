FROM alpine:3.17.0
LABEL maintainer="JulianPrieber"
LABEL description="LittleLink Custom Docker"

EXPOSE 80 443

# Setup apache and php
RUN apk --no-cache --update \
    add apache2 \
    apache2-ssl \
    curl \
    php8-apache2 \
    php8-bcmath \
    php8-bz2 \
    php8-calendar \
    php8-common \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-fileinfo \
    php8-gd \
    php8-iconv \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-mysqlnd \
    php8-openssl \
    php8-pdo_mysql \
    php8-pdo_pgsql \
    php8-pdo_sqlite \
    php8-phar \
    php8-session \
    php8-xml \
    php8-tokenizer \
    php8-zip \
    tzdata \
    && mkdir /htdocs

COPY littlelink-custom /htdocs
RUN chown -R apache:apache /htdocs
RUN find /htdocs -type d -print0 | xargs -0 chmod 0755
RUN find /htdocs -type f -print0 | xargs -0 chmod 0644

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

HEALTHCHECK CMD curl -f http://localhost -A "HealthCheck" || exit 1

# Forward Apache access and error logs to Docker's log collector.
# Optional last line adds extra verbosity with for example:
# [ssl:info] [pid 33] [client 10.0.5.8:45542] AH01964: Connection to child 2 established (server your.domain:443)
RUN ln -sf /dev/stdout /var/www/logs/access.log \
 && ln -sf /dev/stderr /var/www/logs/error.log \
 && ln -sf /dev/stderr /var/www/logs/ssl-access.log
# && ln -sf /dev/stderr /var/www/logs/ssl-error.log

# Set console entry path
WORKDIR /htdocs/littlelink

CMD ["docker-entrypoint.sh"]
