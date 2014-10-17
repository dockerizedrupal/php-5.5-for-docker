class xdebug {
  exec { 'wget http://xdebug.org/files/xdebug-2.2.5.tgz':
    cwd => '/tmp',
    path => ['/usr/bin'],
    require => Class['php']
  }

  exec { 'tar xzf xdebug-2.2.5.tgz':
    cwd => '/tmp',
    path => ['/bin'],
    require => Exec['wget http://xdebug.org/files/xdebug-2.2.5.tgz']
  }

  exec { 'phpize-5.5.17-dev xdebug':
    command => '/phpfarm/inst/bin/phpize-5.5.17-dev',
    cwd => '/tmp/xdebug-2.2.5',
    require => Exec['tar xzf xdebug-2.2.5.tgz']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.5.17-dev"':
    require => Exec['phpize-5.5.17-dev xdebug']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && ./configure --with-php-config=/phpfarm/inst/bin/php-config-5.5.17-dev"']
  }

  exec { '/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make install"':
    require => Exec['/bin/bash -l -c "cd /tmp/xdebug-2.2.5 && make"']
  }
}
