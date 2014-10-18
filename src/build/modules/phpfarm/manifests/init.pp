class phpfarm {
  include phpfarm::packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin'],
    require => Class['phpfarm::packages']
  }

  exec { 'apt-get update':
    path => ['/usr/bin'],
    before => Class['phpfarm::packages']
  }
}
