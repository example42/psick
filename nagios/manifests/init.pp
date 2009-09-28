class nagios {

	include apache

        package {
                "nagios":
	                name   => $operatingsystem ? {
        	                default => "nagios",
                	        },

                        ensure => present,
        }

        service {
                "nagios":
	                name	=> $operatingsystem ? {
        	                default => "nagios",
                	        },
			enable  => "true",
                        require => Package["nagios"],
                        ensure  => "running",
			hasstatus => "true",
        }

        file {
                "cgi.cfg":
                        owner	=> $operatingsystem ?{
				   default => "root",
				   },
                        group	=> $operatingsystem ?{
                                default => "root",
                        	},
                        mode    => 644,
                        require => Package["nagios"],
                        ensure  => present,
                        path    => $operatingsystem ?{
                                default => "/etc/nagios/cgi.cfg",
                                },
        }
        
        file {
                "nagios.cfg":
                        owner	=> $operatingsystem ?{
                                default => "root",
                                },
                        group	=> $operatingsystem ?{
                                default => "root",
                                },
                        mode	=> 644,
                        require	=> Package["nagios"],
                        ensure	=> present,
                        path	=> $operatingsystem ?{
				default => "/etc/nagios/nagios.cfg",
                        	},
        }

        file {
                "nagios.conf":
                        owner	=> $operatingsystem ?{
                                default => "root",
                                },
                        group	=> $operatingsystem ?{
                                default => "root",
                                },
                        mode	=> 644,
                        require => Package["apache"],
                        ensure	=> present,
                        path	=> $operatingsystem ?{
                        	default => "/etc/httpd/conf.d/nagios.conf",
                        	},
        }
        
}
