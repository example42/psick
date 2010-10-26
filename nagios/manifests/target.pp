#
# Class: nagios::target
#
# Basic host target class
# Include it on nodes to be monitored by Nagios
#
# Usage:
# include nagios::target
#
class nagios::target {

    nagios::host { $fqdn: }

#    nagios::hostgroup { "${nagios::params::hostgroups}-$fqdn": 
#        hostgroup => "${nagios::params::hostgroups}",
#    }

}
