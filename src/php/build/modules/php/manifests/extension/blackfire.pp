class php::extension::blackfire {
  require php

  bash_exec { 'mkdir -p /var/run/blackfire': }

  file { '/usr/local/src/phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212/blackfire-php-linux_amd64-php-55.so':
    ensure => present,
    source => 'puppet:///modules/php/tmp/blackfire-php-linux_amd64-php-55.so'
  }

  bash_exec { 'curl -s https://packagecloud.io/gpg.key | apt-key add -': }

  file { '/etc/apt/sources.list.d/blackfire.list':
    ensure => present,
    source => 'puppet:///modules/php/etc/apt/sources.list.d/blackfire.list',
    mode => 644,
    require => Bash_exec['curl -s https://packagecloud.io/gpg.key | apt-key add -']
  }

  bash_exec { 'apt-get update':
    require => File['/etc/apt/sources.list.d/blackfire.list']
  }

  package {[
      'blackfire-agent'
    ]:
    ensure => present,
    require => Bash_exec['apt-get update']
  }
}
