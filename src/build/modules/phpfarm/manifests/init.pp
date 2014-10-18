class phpfarm {
  include phpfarm::packages

  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin'],
    require => Class['phpfarm::packages']
  }
}
