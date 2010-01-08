# Experimental monitor meta-class
# This can be used to monitor hosts with different methods. Using, client-side a standard custom type "monitor"

# Define here the monitor systems you want. If you want use a new one, or more than a single one, customize your $monitor_method variable
# and the relevant operations / includes both in the "monitor" define and in the "monitor::server" class.

import "*.pp"

$monitor_method = "collectd" 

define monitor ( $type='host', $extra='' ) {
# This is the general monitor wrapper, it calls different monitor defines according to the monitor method you've chosen before

	case $monitor_method {

		munin: { 
			munin::plugin { "$name": 
		                ensure      => present,
                		script_path => "$path",
                		config      => "$config",
			} 
		}
 
		collectd: { 
		}
 
		cacti: { 
		}
 
		nagios: { 
		}
 
		default:  {
			err("No Monitor Method. Variable \$monitor_method must be defined" )
		}
	}
}


class monitor::server {
# This is the general monitor class to be used on the monitor server
# It includes the specific monitor class according to your $monitor_method
# If you use different monitor systems and you don't want all the server on a single host, 
# include in your nodes directly the sub-system monitor class

	case $monitor_method {
	
		munin: { 
			include munin::host 
			include apache
		}

		collectd: {
			include collectd
			collectd::plugin { "network":
			        lines => 'Listen "$collectd_server' ,
			}

		}

		cacti:  { include monitor::cacti::server }
		nagios:  { include monitor::nagios::server }
		default:  { err("No Monitor Method. Variable \$monitor_method must be defined" ) }
	}
}


class monitor::target {
# This is the general monitor class to be used on the host you want to monitor
# It includes the specific monitor class according to your $monitor_method
	case $monitor_method {
		
		munin:  { 
			include munin::client
		}
		
		collectd: { 
                        include collectd
                        collectd::conf {
                                'FQDNLookup':
                                        value => 'true';
                                'Server':
                                        value => [ '"$collectd_server" 25825' ];
                                'LoadPlugin':
                                        value => [ 'syslog', 'network', 'cpu' ];
                        }
			
		}
		
		cacti:  { include monitor::cacti::target }
		nagios:  { include monitor::nagios::target }
		default:  { err("No Monitor Method. Variable \$monitor_method must be defined" ) }
	}
}
