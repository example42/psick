class sysctl {


	case $ipforward {
		"yes"  : { $ipforward = "yes" }
		default: { $ipforward = "no" }
	}

	file {	
             	"/etc/sysctl.conf":
			mode => 644, owner => root, group => root,
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/sysctl.conf",
                        },
	}
	exec {
                "sysctl -p":
                        subscribe   => File["/etc/sysctl.conf"],
                        refreshonly => true,
        }
}

class sysctl::hardened inherits sysctl {
	File["/etc/sysctl.conf"] {	
			content => template("sysctl/hardened"),
        }
}
