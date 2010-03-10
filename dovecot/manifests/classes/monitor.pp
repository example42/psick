# Class: dovecot::monitor
#
# Monitors dovecot process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include dovecot::monitor

class dovecot::monitor {

	monitor::port {
		"dovecot_port":
		proto   => "tcp",
		port 	=> 110,
		enable	=> true,
	}

	monitor::port {
		"dovecot_port":
		proto   => "tcp",
		port 	=> 143,
		enable	=> true,
	}

	monitor::port {
		"dovecot_port":
		proto   => "tcp",
		port 	=> 993,
		enable	=> false,
	}

	monitor::port {
		"dovecot_port":
		proto   => "tcp",
		port 	=> 995,
		enable	=> false,
	}

	monitor::process {
		"dovecot_process":
                name 	=> $operatingsystem ? {
                        default => "dovecot",
                        },
		enable	=> true,
	}

	monitor::plugin {
		"dovecot_plugin":
                name 	=> "dovecot",
		enable	=> true,
	}

}
