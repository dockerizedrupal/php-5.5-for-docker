class run::php55::ini::realpath_cache_size {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/realpath_cache_size.ini':
    ensure => present,
    content => template('run/php55/ini/realpath_cache_size.ini.erb'),
    mode => 644
  }
}
