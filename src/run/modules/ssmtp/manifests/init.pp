class ssmtp {
  include ssmtp::packages

  file { '/etc/ssmtp/ssmtp.conf':
    ensure => present,
    content => template('ssmtp/ssmtp.conf.erb'),
    mode => 644,
    require => Class['ssmtp::packages']
  }
}
