class build::php55::extension::zend_debugger {
  require build::php55

  file { '/usr/local/src/phpfarm/inst/current/lib/php/extensions/no-debug-non-zts-20121212/ZendDebugger.so':
    ensure => present,
    source => 'puppet:///modules/build/tmp/ZendDebugger.so'
  }
}
