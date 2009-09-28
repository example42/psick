class psad {
        package {
                "psad":
                name => $operatingsystem ? {
                        default => "psad",
                        },
                ensure => present,
        	}

        package { mailx:
                ensure => present,
        }

	service {
                "psad":
                        enable    => "true",
                        require   => [
                                Package["psad"],
                                File["psad.conf"]
                        ],
                        ensure    => "running",
                        subscribe => File["psad.conf"],
        }

        file {
                "psad.conf":
                        owner   => root,
                        group   => root,
                        mode    => 644,
                        ensure	=> present,
                        require => Package["psad"],
                        path    => $operatingsystem ?{
                                default => "/etc/psad/psad.conf",
                                },
        }

}
