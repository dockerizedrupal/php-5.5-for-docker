class php {
  require php::packages
  require php::phpfarm
  require php::supervisor
  require php::freetds

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.5.18/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212': }

  file { '/tmp/php-5.5.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.5.18.tar.gz'
  }

  bash_exec { 'cd /tmp && zcat php-5.5.18.tar.gz | tar xzf -':
    require => File['/tmp/php-5.5.18.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.5.18 /usr/local/src/phpfarm/src/php-5.5.18':
    require => Bash_exec['cd /tmp && zcat php-5.5.18.tar.gz | tar xzf -']
  }

  file { '/usr/local/src/phpfarm/src/custom/options-5.5.18.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.5.18.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.5.18 /usr/local/src/phpfarm/src/php-5.5.18']
  }

  bash_exec { '/usr/local/src/phpfarm/src/main.sh 5.5.18':
    timeout => 0,
    require => File['/usr/local/src/phpfarm/src/custom/options-5.5.18.sh']
  }

  bash_exec { 'rm -rf /usr/local/src/phpfarm/src/php-5.5.18':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }

  file { '/usr/local/src/phpfarm/inst/php-5.5.18/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }

  bash_exec { 'switch-phpfarm 5.5.18':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }
}
