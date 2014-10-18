# docker-php-5.5-dev

## Run the container

    CONTAINER="php55-dev" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 9000:9000 \
      --link mailcatcher:ssmtp \
      -v /var/www:/var/www \
      -d \
      simpledrupalcloud/php:5.5-dev

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.5-dev \
      && sudo docker build -t simpledrupalcloud/php:5.5-dev . \
      && cd -

## Apache directives

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php55-dev /var/www/php55-dev
      FastCgiExternalServer /var/www/php55-dev -host 127.0.0.1:9000 -idle-timeout 300 -pass-header Authorization

      <Location /php55-dev>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php55-dev
    </IfModule>
