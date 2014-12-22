class php::extension::zend_debugger {
  require php

  exec { 'mkdir -p /phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212':
    path => ['/bin']
  }

  file { '/phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/php/tmp/ZendDebugger.so',
    require => Exec['mkdir -p /phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212']
  }
}
