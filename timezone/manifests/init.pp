class timezone {

         file {
                "timezone":
#                        mode => 644, owner => root, group => root,
                        ensure => present,
                        path => $operatingsystem ?{
                                debian  => "/etc/timezone",
                                ubuntu  => "/etc/timezone",
                                redhat  => "/etc/sysconfig/clock",
                                centos  => "/etc/sysconfig/clock",
                        },

			content => $operatingsystem ?{
                          	default => template("timezone/timezone-${operatingsystem}"),
                        },
#			notify => Exec["set-timezone"],
        }
         
	exec {
                "set-timezone":
                        command => $operatingsystem ?{
                                debian  => "dpkg-reconfigure -f noninteractive tzdata",
                                ubuntu  => "dpkg-reconfigure -f noninteractive tzdata",
                                redhat  => "tzdata-update",
                                centos  => "tzdata-update",
                        },
			require => File["timezone"],
			subscribe => File["timezone"],
			refreshonly => true,
        }

}
