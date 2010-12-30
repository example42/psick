class nagios::nsca::server {

  package { 'nsca': ensure => installed }
  
  service { 'nsca':
    ensure     => running,
    hasstatus  => false,
    hasrestart => true,
  }
  
  file { '/etc/nsca.cfg':
    source => [ "puppet://${server}/site-nagios/nsca/{$fqdn}/nsca.cfg",
        "puppet://${server}/site-nagios/nsca/nsca.cfg",
        "puppet://${server}/nagios/nsca/nsca.cfg" ],
    owner  => 'nagios',
    group  => 'nogroup',
    mode   => '400',
    notify => Service['nsca'],
  }
  
}
