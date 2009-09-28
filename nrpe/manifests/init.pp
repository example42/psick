class nrpe {
        package {
                "nrpe":
                        ensure => "present",
			name   => $extrarepo ? {
				epel     => "nrpe",
				rpmforge => "nagios-nrpe",
				default  => "nrpe",
        		};
        }
	
	case $extrarepo {
		epel: { 
        		package {
				"nagios-plugins-dig":
                        		ensure => "present";
				"nagios-plugins-disk":
                        		ensure => "present";
				"nagios-plugins-dns":
                        		ensure => "present";
				"nagios-plugins-file_age":
                        		ensure => "present";
				"nagios-plugins-http":
                        		ensure => "present";
				"nagios-plugins-ldap":
                        		ensure => "present";
				"nagios-plugins-load":
                        		ensure => "present";
				"nagios-plugins-log":
                        		ensure => "present";
				"nagios-plugins-mysql":
                        		ensure => "present";
				"nagios-plugins-nagios":
                        		ensure => "present";
				"nagios-plugins-nrpe":
                        		ensure => "present";
				"nagios-plugins-ntp":
                        		ensure => "present";
				"nagios-plugins-ping":
                        		ensure => "present";
				"nagios-plugins-procs":
                        		ensure => "present";
				"nagios-plugins-rpc":
                        		ensure => "present";
				"nagios-plugins-smtp":
                        		ensure => "present";
				"nagios-plugins-snmp":
                        		ensure => "present";
				"nagios-plugins-ssh":
                        		ensure => "present";
				"nagios-plugins-swap":
                        		ensure => "present";
				"nagios-plugins-tcp":
                        		ensure => "present";
				"nagios-plugins-udp":
                        		ensure => "present";
				"nagios-plugins-users":
                        		ensure => "present";
        		}
        	}

		rpmforge: { 
        		package {
				"nagios-plugins":
                        		ensure => "present";
        		}
        	}

		default: { 
        		package {
				"nagios-plugins":
                        		ensure => "present";
        		}
        	}
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
        }

        file {
                "nrpe.cfg":
                        owner   => root,
                        group   => root,
                        mode    => 644,
                        ensure	=> present,
                        require => Package["nrpe"],
                        path    => $operatingsystem ?{
                                default => "/etc/nagios/nrpe.cfg",
                                },
        }

}
