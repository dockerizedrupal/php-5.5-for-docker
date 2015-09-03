class build::php55::extension::apd {
  require build::php55

  file { '/tmp/pecl-apd-master.zip':
    ensure => present,
    source => 'puppet:///modules/build/tmp/pecl-apd-master.zip'
  }

  bash_exec { 'cd /tmp && unzip pecl-apd-master.zip':
    require => File['/tmp/pecl-apd-master.zip']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && phpize-5.5.26':
    require => Bash_exec['cd /tmp && unzip pecl-apd-master.zip']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.5.26':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && phpize-5.5.26']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && make':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && ./configure --with-php-config=/usr/local/src/phpfarm/inst/bin/php-config-5.5.26']
  }

  bash_exec { 'cd /tmp/pecl-apd-master && make install':
    timeout => 0,
    require => Bash_exec['cd /tmp/pecl-apd-master && make']
  }
}
