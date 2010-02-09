class cron {

	package { cron:
		name => $operatingsystem ? {
			ubuntu	=> "cron",
			debian	=> "cron",
			redhat	=> "vixie-cron",
			centos	=> "vixie-cron",
			},
		ensure => present,
	}

        service { crond:
                name => $operatingsystem ? {
                        ubuntu  => "cron",
                        debian  => "cron",
                        redhat  => "crond",
                        centos  => "crond",
                        },
                ensure => running,
                enable => true,
                pattern => cron,
		require => Package["cron"],
        }

        case $operatingsystem {
                centos: { include cron::crontabs }
                redhat: { include cron::crontabs }
                default: { }
        }


}
