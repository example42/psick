# Class: apache::monitor
#
# Monitors apache process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include apache::monitor

class apache::monitor {

	monitor {
		"apache_port":
		type	=> "port",
		proto	=> "tcp",
		port 	=> 80,
		address => $ipaddress,
	}

	monitor {
		"apache_process":
		type	=> "process",
                name => $operatingsystem ? {
                        ubuntu  => "apache2",
                        debian  => "apache2",
                        default => "httpd",
                        },
	}

}
