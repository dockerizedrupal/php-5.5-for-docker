define bash_exec (
  $command = $name,
  $user = 'root',
  $creates = undef,
  $cwd = undef,
  $environment = undef,
  $group = undef,
  $logoutput = undef,
  $onlyif = undef,
  $path = undef,
  $provider = "posix",
  $refresh = undef,
  $refreshonly = undef,
  $returns = undef,
  $timeout = undef,
  $tries = undef,
  $try_sleep = undef,
  $umask = undef,
  $unless = undef
) {
  $escaped_command = regsubst($command, "\"", "\\\"", 'G')

  if $unless == undef {
    $escaped_unless = undef
  } else {
    $unless_with_escaped_quotes = regsubst($unless, "\"", "\\\"", 'G')
    $escaped_unless = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${unless_with_escaped_quotes}\\\"\""
  }

  if $onlyif == undef {
    $escaped_onlyif = undef
  } else {
    $onlyif_with_escaped_quotes = regsubst($onlyif, "\"", "\\\"", 'G')
    $escaped_onlyif = "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${onlyif_with_escaped_quotes}\\\"\""
  }

  exec { $name:
    command => "/bin/su -l ${user} -c \"/bin/bash --login -c \\\"${escaped_command}\\\"\"",
    creates => $creates,
    cwd => $cwd,
    environment => $environment,
    group => $group,
    logoutput => $logoutput,
    onlyif => $escaped_onlyif,
    path => $path,
    provider => $provider,
    refresh => $refresh,
    refreshonly => $refreshonly,
    returns => $returns,
    timeout => $timeout,
    tries => $tries,
    try_sleep => $try_sleep,
    umask => $umask,
    unless => $escaped_unless
  }
}

class php {
  require php::packages
  require php::phpfarm
  require php::supervisor
  require php::freetds

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.5.18/etc/conf.d': }

  bash_exec { 'mkdir -p /usr/local/src/phpfarm/inst/php-5.5.18/lib/php/extensions/no-debug-non-zts-20121212': }

  file { '/tmp/php-5.5.18.tar.gz':
    ensure => present,
    source => 'puppet:///modules/php/tmp/php-5.5.18.tar.gz'
  }

  bash_exec { 'cd /tmp && zcat php-5.5.18.tar.gz | tar xzf -':
    require => File['/tmp/php-5.5.18.tar.gz']
  }

  bash_exec { 'mv /tmp/php-5.5.18 /usr/local/src/phpfarm/src/php-5.5.18':
    require => Bash_exec['cd /tmp && zcat php-5.5.18.tar.gz | tar xzf -']
  }

  file { '/usr/local/src/phpfarm/src/custom/options-5.5.18.sh':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/src/custom/options-5.5.18.sh',
    mode => 755,
    require => Bash_exec['mv /tmp/php-5.5.18 /usr/local/src/phpfarm/src/php-5.5.18']
  }

  bash_exec { '/usr/local/src/phpfarm/src/main.sh 5.5.18':
    timeout => 0,
    require => File['/usr/local/src/phpfarm/src/custom/options-5.5.18.sh']
  }

  bash_exec { 'rm -rf /usr/local/src/phpfarm/src/php-5.5.18':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }

  file { '/usr/local/src/phpfarm/inst/php-5.5.18/etc/php-fpm.conf':
    ensure => present,
    source => 'puppet:///modules/php/phpfarm/inst/php-5.5.18/etc/php-fpm.conf',
    mode => 644,
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }

  bash_exec { 'switch-phpfarm 5.5.18':
    require => Bash_exec['/usr/local/src/phpfarm/src/main.sh 5.5.18']
  }
}
