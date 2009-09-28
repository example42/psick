class clock {

         file {
                "clock":
                        mode => 644, owner => root, group => root,
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/sysconfig/clock",
                        },
			content => $operatingsystem ?{
                          	default => template("clock/clock"),
                        },
        }
}
