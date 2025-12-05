#!/bin/sh

# Exit on non defined variables and on non zero exit codes
set -eu

# + ---------- + #
# | -- VARS -- | #
# + ---------- + #

export SERVER_ADMIN="${SERVER_ADMIN:-you@example.com}"
export HTTP_SERVER_NAME="${HTTP_SERVER_NAME:-localhost}"
export HTTPS_SERVER_NAME="${HTTPS_SERVER_NAME:-localhost}"
export LOG_LEVEL="${LOG_LEVEL:-info}"
export TZ="${TZ:-UTC}"
export PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:-256M}"
export UPLOAD_MAX_FILESIZE="${UPLOAD_MAX_FILESIZE:-8M}"

# Read Current LLC Version
# When version.json has CR/LF, it fx up, so have to add tr to remove the line endings.
v="$(cat /htdocs/version.json | tr -d '\r\n')"

# Calc length of whitespace we need, based on version length.
vlen="$((27-${#v}))"

echo '+ ------------------------------------------------------------------ +'
printf '|                      LINKSTACK v%s%*s|\n' "${v}" "$vlen" | tr ' ' " "

# + ---------------- + #
# | -- HTTPD.CONF -- | #
# + ---------------- + #

echo '+ ------------------------------------------------------------------ +'
echo '| Updating Configuration: Apache Base (/etc/apache2/httpd.conf)      |'
echo '| Updating Configuration: Apache SSL  (/etc/apache2/conf.d/ssl.conf) |'

# + ------------- + #
# | -- PHP.INI -- | #
# + ------------- + #

echo '| Updating Configuration: PHP         (/etc/php83/40-custom.ini)     |'
echo "| Setting PHP Configuration:                                         |"
echo "| upload_max_filesize = ${UPLOAD_MAX_FILESIZE}                       |"
echo "| memory_limit = ${PHP_MEMORY_LIMIT}                                 |"
echo "| date.timezone = ${TZ}                                              |"

echo "upload_max_filesize = ${UPLOAD_MAX_FILESIZE}" >> /etc/php83/conf.d/40-custom.ini
echo "memory_limit = ${PHP_MEMORY_LIMIT}" >> /etc/php83/conf.d/40-custom.ini
echo "date.timezone = ${TZ}" >> /etc/php83/conf.d/40-custom.ini

# + ---------- + #
# | -- MISC -- | #
# + ---------- + #

# Apache gets grumpy about PID files pre-existing
rm -f /htdocs/httpd.pid
echo '| Updating Configuration: Complete                                   |'
echo '| ------------------------------------------------------------------ |'
echo '| Running Apache                                                     |'
echo '+ ------------------------------------------------------------------ +'
echo

httpd -D FOREGROUND