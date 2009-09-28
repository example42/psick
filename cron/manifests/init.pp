class cron {

	package { cron:
		name => $operatingsystem ? {
			default	=> "vixie-cron",
			},
		ensure => present,
	}

	package { crontabs:
		name => $operatingsystem ? {
			default	=> "crontabs",
			},
		ensure => present,
	}

        service { crond:
                name => $operatingsystem ? {
                        default => "crond",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                hasstatus => true,
                require => Package[cron],
        }

}
