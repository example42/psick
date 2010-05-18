class nagios::nsca::client {

  package { 'nsca': ensure => installed }
  
  file { '/etc/send_nsca.cfg':
    source => [ "puppet://${server}/site-nagios/nsca/{$fqdn}/send_nsca.cfg",
        "puppet://${server}/site-nagios/nsca/send_nsca.cfg",
        "puppet://${server}/nagios/nsca/send_nsca.cfg" ],
    owner  => 'nagios',
    group  => 'nogroup',
    mode   => '400',
  }

}
