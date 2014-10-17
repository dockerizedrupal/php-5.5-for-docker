class phpfarm {
  exec { 'git clone git://git.code.sf.net/p/phpfarm/code phpfarm':
    cwd => '/',
    path => ['/usr/bin']
  }

#  exec { 'apt-get update':
#    path => ['/usr/bin'],
#    before => Class['packages']
#  }
}
