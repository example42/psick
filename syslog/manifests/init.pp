class syslog {
        package {
                "syslogd":
                ensure => present,
                name => $operatingsystem ? {
                        default => "sysklogd",
                        },
        }

        file {
                "syslog.conf":
                owner   => "root",
                group   => "root",
                mode    => "644",
                require   => Package["syslogd"],
                path    => $operatingsystem ?{
                           default => "/etc/syslog.conf",
                           },
                content => template("syslog/syslog.conf.erb"),
	}

        file {
                "syslog":
                owner   => "root",
                group   => "root",
                mode    => "644",
                require   => Package["syslogd"],
                path    => $operatingsystem ?{
                           default => "/etc/sysconfig/syslog",
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

class syslog::server inherits syslog {
        File["syslog.conf"] {
                content => template("syslog/server/syslog.conf.erb"),
        }
        File["syslog"] {
                content => template("syslog/server/syslog.erb"),
        }
}

class syslog::disable inherits syslog {
        Service["syslog"] {
                ensure => "stopped" ,
                enable => "false",
        }
}

