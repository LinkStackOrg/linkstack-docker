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

# + ---------- + #
# | -- MISC -- | #
# + ---------- + #

# Apache gets grumpy about PID files pre-existing
rm -f /htdocs/httpd.pid

echo '| ------------------------------------------------------------------ |'
echo '| Running Apache                                                     |'
echo '+ ------------------------------------------------------------------ +'
echo

httpd -D FOREGROUND
