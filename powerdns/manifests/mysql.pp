define powerdns::mysql( $host = '127.0.0.1', $user = 'power_admin', $password, $dbname = 'powerdns', $template = 'powerdns/pdns_local.erb') {

	file {"/etc/powerdns/pdns.d/pdns.local":
        content => template($template),
        mode    => 644,
		owner => root, 
		group => root,
        require => Package['powerdns'],
        notify => Service['powerdns'],
    }
}