#!/bin/sh

# Exit on non defined variables and on non zero exit codes
set -eu

# + ---------- + #
# | -- VARS -- | #
# + ---------- + #

SERVER_ADMIN="${SERVER_ADMIN:-you@example.com}"
HTTP_SERVER_NAME="${HTTP_SERVER_NAME:-localhost}"
HTTPS_SERVER_NAME="${HTTPS_SERVER_NAME:-localhost}"
LOG_LEVEL="${LOG_LEVEL:-info}"
TZ="${TZ:-UTC}"
PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:-256M}"
UPLOAD_MAX_FILESIZE="${UPLOAD_MAX_FILESIZE:-8M}"

# If TRUE, outputs pre and post-change config files, if a /debug folder has also been mounted.
#          i.e. - '/opt/docker/configs/linkstack/debug:/debug:rw'
#          Useful for comparing (and fixing) changes, if necessary.
DEBUG="TRUE"

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

# ALTER: Server Admin, Name, Document Root.

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/apache2/httpd.conf /debug/httpd.BEFORE.conf;fi

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/apache2/httpd.conf /debug/httpd.AFTER.conf;fi

# + -------------- + #
# | -- SSL.CONF -- | #
# + -------------- + #

echo '| Updating Configuration: Apache SSL  (/etc/apache2/conf.d/ssl.conf) |'

# ALTER: SSL DocumentRoot and Log locations

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/apache2/conf.d/ssl.conf /debug/ssl.BEFORE.conf;fi

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/apache2/conf.d/ssl.conf /debug/ssl.AFTER.conf;fi

# + ------------- + #
# | -- PHP.INI -- | #
# + ------------- + #

echo '| Updating Configuration: PHP         (/etc/php82/php.ini)            |'

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/php82/php.ini /debug/php.BEFORE.ini;fi

if [[ ${DEBUG} == "TRUE" && -d /debug ]]; then cp /etc/php82/php.ini /debug/php.AFTER.ini;fi

# + ---------- + #
# | -- MISC -- | #
# + ---------- + #

echo '| Updating Configuration: Complete                                   |'
echo '| ------------------------------------------------------------------ |'
echo '| Running Apache                                                     |'
echo '+ ------------------------------------------------------------------ +'
echo

httpd -D FOREGROUND
