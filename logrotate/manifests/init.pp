class logrotate {

	package { logrotate:
		name => $operatingsystem ? {
			ubuntu	=> "logrotate",
			debian	=> "logrotate",
			redhat	=> "logrotate",
			centos	=> "logrotate",
			},
		ensure => present,
	}

}
