class php::extension::zend_debugger {
  require php

  file { '/phpfarm/inst/php-5.5.17/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.17/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so'
  }
}
