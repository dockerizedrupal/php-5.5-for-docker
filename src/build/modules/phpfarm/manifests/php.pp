class phpfarm::php {
  include phpfarm

  file { '/phpfarm/src/custom-options-5.5.17-dev.sh':
    ensure => present,
    source => file('phpfarm/phpfarm/src/custom-options-5.5.17-dev.sh'),
    mode => 755,
    require => Class['phpfarm']
  }

#  exec { '/phpfarm/src/compile.sh 5.5.17-dev':
#    timeout => 0,
#    require => File['phpfarm/src/custom-options-5.5.17-dev.sh']
#  }
#
#  exec { 'rm -rf /phpfarm/src/php-5.5.17-dev':
#    path => ['/bin'],
#    require => Exec['/phpfarm/src/compile.sh 5.5.17-dev']
#  }
#
#  file { '/phpfarm/inst/php-5.5.17-dev/etc/php-fpm.conf':
#    ensure => present,
#    source => File['phpfarm/phpfarm/inst/php-5.5.17-dev/etc/php-fpm.conf'],
#    mode => 644,
#    require => Exec['/phpfarm/src/compile.sh 5.5.17-dev']
#  }
#
#  file { '/phpfarm/inst/php-5.5.17-dev/lib/php.ini':
#    ensure => present,
#    source => File['phpfarm/phpfarm/inst/php-5.5.17-dev/lib/php.ini'],
#    mode => 644,
#    require => Exec['/phpfarm/src/compile.sh 5.5.17-dev']
#  }
#
#  file { '/etc/profile.d/phpfarm.sh':
#    ensure => present,
#    source => File['phpfarm/etc/profile.d/phpfarm.sh'],
#    mode => 755,
#    require => Exec['/phpfarm/src/compile.sh 5.5.17-dev']
#  }
#
#  exec { '/bin/bash -l -c "switch-phpfarm 5.5.17-dev"':
#    require => File['/etc/profile.d/phpfarm.sh']
#  }
#
#  file { '/etc/supervisor/conf.d/php.conf':
#    ensure => present,
#    source => File['phpfarm/etc/supervisor/conf.d/php.conf']
#  }
}
