FROM alpine:3.17.3
LABEL maintainer="JulianPrieber"
LABEL description="LinkStack Docker"

EXPOSE 80 443

# Setup apache and php
RUN apk --no-cache --update \
    add apache2 \
    apache2-ssl \
    curl \
    php81-apache2 \
    php81-bcmath \
    php81-bz2 \
    php81-calendar \
    php81-common \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-fileinfo \
    php81-gd \
    php81-iconv \
    php81-json \
    php81-mbstring \
    php81-mysqli \
    php81-mysqlnd \
    php81-openssl \
    php81-pdo_mysql \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-phar \
    php81-session \
    php81-xml \
    php81-tokenizer \
    php81-zip \
    php81-xmlwriter \
    tzdata \
    && mkdir /htdocs

COPY linkstack /htdocs
RUN chown -R apache:apache /htdocs
RUN find /htdocs -type d -print0 | xargs -0 chmod 0755
RUN find /htdocs -type f -print0 | xargs -0 chmod 0644

COPY --chmod=0755 docker-entrypoint.sh /usr/local/bin/

HEALTHCHECK CMD curl -f http://localhost -A "HealthCheck" || exit 1

# Enable compression
RUN sed -i '/LoadModule mime_module/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/LoadModule deflate_module/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType text\/html/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType text\/plain/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType text\/xml/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType application\/javascript/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType text\/css/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType image\/svg\+xml/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType application\/x-font-ttf/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType font\/opentype/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType image\/jpeg/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType image\/png/s/^#//g' /etc/apache2/httpd.conf \
    && sed -i '/AddOutputFilterByType image\/gif/s/^#//g' /etc/apache2/httpd.conf

# Forward Apache access and error logs to Docker's log collector.
# Optional last line adds extra verbosity with for example:
# [ssl:info] [pid 33] [client 10.0.5.8:45542] AH01964: Connection to child 2 established (server your.domain:443)
RUN ln -sf /dev/stdout /var/www/logs/access.log \
 && ln -sf /dev/stderr /var/www/logs/error.log \
 && ln -sf /dev/stderr /var/www/logs/ssl-access.log
# && ln -sf /dev/stderr /var/www/logs/ssl-error.log

# Enable mod_deflate for text compression
RUN sed -i 's/#LoadModule deflate_module/LoadModule deflate_module/' /etc/apache2/httpd.conf \
    && sed -i 's/#LoadModule filter_module/LoadModule filter_module/' /etc/apache2/httpd.conf \
    && echo 'AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/javascript application/json' >> /etc/apache2/httpd.conf

# Set console entry path
WORKDIR /htdocs

CMD ["docker-entrypoint.sh"]