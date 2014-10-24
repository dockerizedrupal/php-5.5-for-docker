class php {
  require php::packages
  require php::supervisor

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin']
  }

  file { '/phpfarm/src/custom-options-5.5.18.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom-options-5.5.18.sh',
    mode => 755,
    require => Exec['git clone git://git.code.sf.net/p/phpfarm/code phpfarm']
  }

  exec { '/phpfarm/src/compile.sh 5.5.18':
    timeout => 0,
    require => File['/phpfarm/src/custom-options-5.5.18.sh']
  }

  exec { 'rm -rf /phpfarm/src/php-5.5.18':
    path => ['/bin'],
    require => Exec['/phpfarm/src/compile.sh 5.5.18']
  }

  file { '/phpfarm/inst/php-5.5.18/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/etc/php-fpm.conf',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.5.18']
  }

  file { '/phpfarm/inst/php-5.5.18/lib/php.ini':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/lib/php.ini',
    mode => 644,
    require => Exec['/phpfarm/src/compile.sh 5.5.18']
  }

  file { '/etc/profile.d/phpfarm.sh':
    ensure => present,
    source => 'puppet:///modules/php/etc/profile.d/phpfarm.sh',
    mode => 755,
    require => Exec['/phpfarm/src/compile.sh 5.5.18']
  }

  exec { '/bin/bash -l -c "switch-phpfarm 5.5.18"':
    require => File['/etc/profile.d/phpfarm.sh']
  }
}
