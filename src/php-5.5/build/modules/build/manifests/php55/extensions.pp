class build::php55::extensions {
  require build::php55

  include build::php55::extension::xdebug
  include build::php55::extension::memcached
  include build::php55::extension::redis
  include build::php55::extension::blackfire
  include build::php55::extension::apcu
  include build::php55::extension::apd
}
