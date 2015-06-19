class php::extension::zend_debugger {
  require php

  file { '/usr/local/src/phpfarm/inst/php-5.5.26/lib/php/extensions/no-debug-non-zts-20121212/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/php/tmp/ZendDebugger.so'
  }
}
