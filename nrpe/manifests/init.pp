class nrpe {

	package {
                "nrpe":
                        ensure => "present",
			name   => $operatingsystem ? {
                                ubuntu  => "nagios-nrpe-server",
                                debian  => "nagios-nrpe-server",
                                centos  => "nrpe", # OK for EPEL, use nagios-nrpe for RPMFORGE
                                redhat  => "nrpe", # OK for EPEL, use nagios-nrpe for RPMFORGE
			},
        }
	
	package {
                "nagios-plugins":
                        ensure => "present",
			name   => $operatingsystem ? {
                                ubuntu  => "nagios-plugins",
                                debian  => "nagios-plugins",
                                centos  => "nagios-plugins-all", # OK for EPEL, use nagios-plugins for RPMFORGE
                                redhat  => "nagios-plugins-all", # OK for EPEL, use nagios-plugins for RPMFORGE
			},
        }
	
	service {
                "nrpe":
                        enable    => "true",
                        require   => [
                                Package["nrpe"],
                                File["nrpe.cfg"]
                        ],
                        ensure    => "running",
                        subscribe => File["nrpe.cfg"],
			name => $operatingsystem ? {
                                ubuntu  => "nagios-nrpe-server",
                                debian  => "nagios-nrpe-server",
                                centos  => "nrpe",
                                redhat  => "nrpe",
                        },
			pattern   => "nrpe",
        }

        file {
                "nrpe.cfg":
#                        owner => root, group => root, mode => 644,
                        ensure	=> present,
                        require => Package["nrpe"],
                        path    => $operatingsystem ?{
                                default => "/etc/nagios/nrpe.cfg",
                                },
        }

}
