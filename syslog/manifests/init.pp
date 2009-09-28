class syslog {
        package {
                "syslogd":
                ensure => present,
                name => $operatingsystem ? {
                        default => "sysklogd",
                        },
        }

        package {
                "logrotate":
                ensure => present,
                name => $operatingsystem ? {
                        default => "logrotate",
                        },
        }

        file {
                "syslog.conf":
                owner   => "root",
                group   => "root",
                mode    => "640",
                require   => Package["syslogd"],
                path    => $operatingsystem ?{
                           default => "/etc/syslog.conf",
                           },

	}

        service {
                "syslog":
                enable    => "true",
                ensure    => "running",
                hasstatus => "true",
                require   => File["syslog.conf"],
                subscribe => File["syslog.conf"],
                name => $operatingsystem ? {
                        default => "syslog",
                        },
        }

}

