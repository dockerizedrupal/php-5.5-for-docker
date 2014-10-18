class phpfarm::php::extension::zend_debugger {
  require phpfarm::php

  file { '/phpfarm/inst/php-5.5.17/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/phpfarm/phpfarm/inst/php-5.5.17/lib/php/extensions/ZendDebugger-linux-x86_64/php-5.5.x/ZendDebugger.so'
  }
}
