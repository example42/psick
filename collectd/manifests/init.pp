class collectd {

	package {
		'collectd':
			name => $operatingsystem ? {
                                default => "collectd",
                        },
			ensure => installed;
	}

	service {
		'collectd':
			ensure => running,
			enable => true,
			hasrestart => true,
			pattern => collectd,
			require => Package['collectd'];
	}

	file {
		'collectd.conf':
			ensure => present,
			path => $operatingsystem ? {
				debian  => "/etc/collectd/collectd.conf",
				default => "/etc/collectd.conf",
			},
#			mode => 0644, owner => root, group => 0,
			require => Package['collectd'],
			notify => Service['collectd'];
	}


# Brutal force of /etc/collectd.d/ directory for plugins
# To adapt or accept

        collectd::conf {
                'Include':
                        value =>  $operatingsystem ? {
                                default => "/etc/collectd.d",
                        };
                'Hostname':
                        value =>  $fqdn,
        }

	file {
		'collectd.d':
			path => "/etc/collectd.d",
			ensure => directory,
	}


}
