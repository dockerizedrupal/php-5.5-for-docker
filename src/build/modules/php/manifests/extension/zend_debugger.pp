class php::extension::zend_debugger {
  require php

  exec { 'mkdir -p /phpfarm/inst/php-5.5.18/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x':
    path => ['/bin']
  }

  file { '/phpfarm/inst/php-5.5.18/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so',
    require => Exec['mkdir -p /phpfarm/inst/php-5.5.18/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x']
  }
}
