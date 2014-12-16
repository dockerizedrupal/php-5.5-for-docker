# docker-php

A [Docker](https://docker.com/) container for [PHP](http://php.net/) version 5.5.18 that runs PHP in FPM (FastCGI Process Manager) mode.

## Run the container

Using the `docker` command:

    CONTAINER="httpddata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /httpd/data \
      simpledrupalcloud/data:latest
      
    CONTAINER="php" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      --volumes-from httpddata \
      -d \
      simpledrupalcloud/php:5.5
      
Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.5 \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.5 \
      && sudo docker build -t simpledrupalcloud/php:5.5 . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php55 /httpd/php55
      FastCgiExternalServer /httpd/php55 -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php55>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php55
    </IfModule>

## License

**MIT**
