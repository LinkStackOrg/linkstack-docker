#!/bin/sh

# Exit on non defined variables and on non zero exit codes
set -eu

echo 'Building the container'

docker build ./ -t alpine-apache-php-ci:latest

NET="${DOCKER_NETWORK:-alpine-apache-php-autotest}"

# use failure to switch on create
docker network inspect ${NET} 1>/dev/null 2> /dev/null || docker network create ${NET}

echo 'Preparing test folder'

TMP_DIR="$(mktemp -d --suffix alpine-apache-php)"

printf "<?php \n\
    echo 'PHP: ' . PHP_MAJOR_VERSION . PHP_EOL;\n\
    echo 'Admin: ' . \$_SERVER['SERVER_ADMIN'] . PHP_EOL;\n\
    echo 'Host: ' . \$_SERVER['SERVER_NAME'] . PHP_EOL;\n\
    echo 'Memory-limit: ' . ini_get('memory_limit') . PHP_EOL;\n\
    echo 'Timezone: ' . ini_get('date.timezone') . PHP_EOL;\n\
    " > "${TMP_DIR}/index.php"

chmod 777 "${TMP_DIR}"
chmod 666 "${TMP_DIR}/index.php"

echo 'Running test containers'

# stop if exists or silently exit
docker stop alpine-apache-php-test 1>/dev/null 2> /dev/null || echo '' >/dev/null

docker run --rm --detach \
    --name alpine-apache-php-test \
    --network ${NET} \
    --volume ${TMP_DIR}:/htdocs \
    --env HTTP_SERVER_NAME="www.example.xyz" \
    --env HTTPS_SERVER_NAME="www.example.xyz" \
    --env SERVER_ADMIN="admin@example.xyz" \
    --env TZ="Europe/Paris" \
    --env PHP_MEMORY_LIMIT="512M" \
    alpine-apache-php-ci:latest 1>/dev/null


# stop if exists or silently exit
docker stop alpine-apache-php-test-normal 1>/dev/null 2> /dev/null || echo '' >/dev/null

docker run --rm --detach \
    --name alpine-apache-php-test-normal \
    --network ${NET} \
    --volume ${TMP_DIR}:/htdocs \
    alpine-apache-php-ci:latest 1>/dev/null

echo ''
echo 'Running custom tests'

docker run --rm --network ${NET} curlimages/curl:latest -s -k https://alpine-apache-php-test -H 'Host: www.example.xyz'
docker run --rm --network ${NET} curlimages/curl:latest -s http://alpine-apache-php-test
docker run --rm --network ${NET} curlimages/curl:latest -s -k https://alpine-apache-php-test

echo ''
echo 'Running normal tests'

docker run --rm --network ${NET} curlimages/curl:latest -s -k https://alpine-apache-php-test-normal -H 'Host: www.example.xyz'
docker run --rm --network ${NET} curlimages/curl:latest -s http://alpine-apache-php-test-normal
docker run --rm --network ${NET} curlimages/curl:latest -s -k https://alpine-apache-php-test-normal

echo ''
echo 'Cleaning up'
docker stop alpine-apache-php-test 1>/dev/null
docker stop alpine-apache-php-test-normal 1>/dev/null
docker network rm ${NET} 1>/dev/null

rm "${TMP_DIR}/index.php"
rmdir "${TMP_DIR}"
