#!/bin/sh

# Exit on non defined variables and on non zero exit codes
set -eu

# Get/Set Variables
SERVER_ADMIN="${SERVER_ADMIN:-you@example.com}"
HTTP_SERVER_NAME="${HTTP_SERVER_NAME:-localhost}"
HTTPS_SERVER_NAME="${HTTPS_SERVER_NAME:-localhost}"
LOG_LEVEL="${LOG_LEVEL:-info}"
TZ="${TZ:-UTC}"
PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:-256M}"
UPLOAD_MAX_FILESIZE="${UPLOAD_MAX_FILESIZE:-8M}"

echo 'Updating Configuration: Apache Base (/etc/apache2/httpd.conf)'

# Change Server Admin, Name, Document Root
sed -i "s/ServerAdmin\ you@example.com/ServerAdmin\ ${SERVER_ADMIN}/" /etc/apache2/httpd.conf
sed -i "s/#ServerName\ www.example.com:80/ServerName\ ${HTTP_SERVER_NAME}/" /etc/apache2/httpd.conf
sed -i 's#^DocumentRoot ".*#DocumentRoot "/htdocs"#g' /etc/apache2/httpd.conf
sed -i 's#Directory "/var/www/localhost/htdocs"#Directory "/htdocs"#g' /etc/apache2/httpd.conf
sed -i 's#AllowOverride None#AllowOverride All#' /etc/apache2/httpd.conf

# Change TransferLog after ErrorLog
sed -i 's#^ErrorLog .*#ErrorLog "logs/error.log"#g' /etc/apache2/httpd.conf
sed -i 's#LogFormat .* %t#LogFormat "[%{%a %b %d %H:%M:%S}t.%{usec_frac}t %{%Y}t] [httpd.conf] %h %l %u#g' /etc/apache2/httpd.conf
sed -i 's#CustomLog .* combined#BrowserMatchNoCase ^healthcheck nolog\n\n    CustomLog "logs/access.log" combinedio env=!nolog\n#g' /etc/apache2/httpd.conf

# Re-define LogLevel
sed -i "s#^LogLevel .*#LogLevel ${LOG_LEVEL}#g" /etc/apache2/httpd.conf

# Enable commonly used apache modules
sed -i 's/#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf
sed -i 's/#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf
sed -i 's/#LoadModule\ logio_module/LoadModule\ logio_module/' /etc/apache2/httpd.conf
sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf

echo 'Updating Configuration: Apache SSL  (/etc/apache2/conf.d/ssl.conf)'

# SSL DocumentRoot and Log locations
sed -i 's#^ErrorLog .*#ErrorLog "logs/ssl-error.log"#g' /etc/apache2/conf.d/ssl.conf
sed -i "s/^TransferLog .*/#TransferLog \"logs\/ssl-transfer.log\"\nLogLevel ${LOG_LEVEL}/g" /etc/apache2/conf.d/ssl.conf
sed -i 's#^DocumentRoot ".*#DocumentRoot "/htdocs"#g' /etc/apache2/conf.d/ssl.conf
sed -i "s/ServerAdmin\ you@example.com/ServerAdmin\ ${SERVER_ADMIN}/" /etc/apache2/conf.d/ssl.conf
sed -i "s/ServerName\ www.example.com:443/ServerName\ ${HTTPS_SERVER_NAME}/" /etc/apache2/conf.d/ssl.conf

sed -i 's#CustomLog .*#LogFormat "[%{%a %b %d %H:%M:%S}t.%{usec_frac}t %{%Y}t] [ssl.conf] %h %l %u \\"%r\\" %>s %b \\"%{Referer}i\\" \\"%{User-Agent}i\\"" combined\n\nCustomLog "logs/ssl-access.log" combined#g' /etc/apache2/conf.d/ssl.conf
sed -i '/.*%{SSL_PROTOCOL}x.*/d' /etc/apache2/conf.d/ssl.conf

echo 'Updating Configuration: PHP         (/etc/php8/php.ini)'

# Modify php memory limit and timezone
sed -i "s/memory_limit = .*/memory_limit = ${PHP_MEMORY_LIMIT}/" /etc/php8/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = ${UPLOAD_MAX_FILESIZE}/" /etc/php8/php.ini
sed -i "s#^;date.timezone =\$#date.timezone = \"${TZ}\"#" /etc/php8/php.ini

echo "is_llc_docker = true" >> /etc/php8/php.ini

echo 'Updating Configuration: Complete'
echo 'Running Apache'

httpd -D FOREGROUND
