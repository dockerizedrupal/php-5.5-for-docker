class phpfarm {
  include packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin'],
    require => Class['packages']
  }

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['packages']
  }
}
