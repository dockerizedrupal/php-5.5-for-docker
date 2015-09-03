class run::php55::ini::apcu {
  file { '/usr/local/src/phpfarm/inst/current/etc/conf.d/apcu.ini':
    ensure => present,
    content => template('run/php55/ini/apcu.ini.erb'),
    mode => 644
  }
}
