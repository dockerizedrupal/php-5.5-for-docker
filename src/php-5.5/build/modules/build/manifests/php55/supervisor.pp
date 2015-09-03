class build::php55::supervisor {
  file { '/etc/supervisor/conf.d/php-5.5.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/php-5.5.conf',
    mode => 644
  }
}
