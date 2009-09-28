class syslog-ng inherits syslog {
        package {
                "syslog-ng":
                        ensure => "present";
        }

        Service["syslog"]{
                enable    => "false",
                ensure    => "stopped",
        }

        Package["syslogd"]{
                ensure    => "absent",
        }

        service {
                "syslog-ng":
                enable    => "true",
                ensure    => "running",
                require   => File["syslog-ng.conf"],
                subscribe => File["syslog-ng.conf"],
        }

        file {
                "syslog-ng.conf":
                        owner   => "root",
                        group   => "root",
                        mode    => "640",
                        require => Package["syslog-ng"],
                        ensure  => present,
			path => $operatingsystem ?{
                                default => "/etc/syslog-ng/syslog-ng.conf",
                        },
        }
        
}
                        

class syslog-ng::central inherits syslog-ng {

	file {
                "/var/log/central":
                        owner   => "root",
                        group   => "root",
                        mode    => "755",
                        ensure  => "directory",
        }

	File["syslog-ng.conf"]{
		source  => "puppet://$servername/syslog-ng/syslog-ng.conf",
	}

}

class syslog-ng::mysql inherits syslog-ng {

	File["syslog-ng.conf"]{
		source  => "puppet://$servername/syslog-ng/syslog-ng.conf-mysql",
	}

}

