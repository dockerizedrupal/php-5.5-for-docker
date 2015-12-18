class build::php55::extensions {
  require build::php55

  include build::php55::extensions::xdebug
  include build::php55::extensions::memcached
  include build::php55::extensions::redis
  include build::php55::extensions::blackfire
  include build::php55::extensions::apcu
  include build::php55::extensions::apd
}
