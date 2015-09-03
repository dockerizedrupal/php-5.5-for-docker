#!/usr/bin/env bash

case "${1}" in
  build)
    /bin/su - root -mc "apt-get update && /src/php-5.5/build.sh && /src/php-5.5/clean.sh"
    ;;
  run)
    /bin/su - root -mc "source /src/php-5.5/variables.sh && /src/php-5.5/run.sh"
    ;;
esac
