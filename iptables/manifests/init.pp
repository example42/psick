class iptables {

	service { iptables:
		name => $operatingsystem ? {
                        default => "iptables",
                        },
		ensure => running,
		enable => true,
		hasrestart => false,
		restart => "iptables-restore < /etc/sysconfig/iptables",
		hasstatus => true,
		# Uncomment to automatic iptables restart on config change (Careful!!)
		# subscribe File["iptables"],
	}

	file {	
             	"iptables":
			mode => 600, owner => root, group => root,
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/sysconfig/iptables",
                        },
	}

}

class iptables::disable inherits iptables {
        Service ["iptables"] {
                ensure => stopped,
                enable => false,
        }

}

