class phpfarm::php {
  include phpfarm

  file { '/phpfarm/src/custom-options-5.5.17.sh':
    ensure => present,
    source => 'puppet:///modules/phpfarm/phpfarm/src/custom-options-5.5.17.sh',
    mode => 755,
    require => Class['phpfarm']
  }

  exec { '/phpfarm/src/compile.sh 5.5.17':
    timeout => 0,
    require => File['/phpfarm/src/custom-options-5.5.17.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.5.17':
    path => ['/bin'],
    require => Exec['/phpfarm/src/compile.sh 5.5.17']
  }

  file { '/phpfarm/inst/php-5.5.17/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/phpfarm/phpfarm/inst/php-5.5.17/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.5.17']
  }

  file { '/phpfarm/inst/php-5.5.17/lib/php.ini':
    ensure => present,
    source => 'puppet:///modules/phpfarm/phpfarm/inst/php-5.5.17/lib/php.ini',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.5.17']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/phpfarm/etc/profile.d/phpfarm.sh',
    mode => 755,
    require => Exec['/phpfarm/src/compile.sh 5.5.17']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.5.17"':
    require => File['/etc/profile.d/phpfarm.sh']
  }

  file { '/etc/supervisor/conf.d/php.conf':
    ensure => present,
    source => 'puppet:///modules/phpfarm/etc/supervisor/conf.d/php.conf'
  }
}
