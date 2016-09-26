#!/bin/sh
#
# Script to build images
#

: ${PROJECT_NAME:='mariadb-galera'}
: ${MARIADB_VERSION:='5.5'}
. ./lib.sh
DOCKER_TAG=${MARIADB_VERSION}

set -e

ACTION="$1"

echo ''
info "$0 $@"
docker_options
docker_warm_cache

case $ACTION in
build)
    create_image
    ;;
publish_docker_image)
    publish_docker_image
    ;;
ci_docker_login)
    ci_docker_login
    ;;
*)
    usage
    ;;
esac
