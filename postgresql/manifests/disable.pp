# Class: postgresql::disable
#
# Stops postgresql service and disables it at boot time
# Removes the monitor checks.
# Use postgresql::absent to remove everything
#
# Usage:
# include postgresql::disable
#
class postgresql::disable inherits postgresql {

    require postgresql::params

    Service["postgresql"] {
        ensure => "stopped" ,
        enable => "false",
    }

    # Remove relevant monitor entries
    if $monitor == "yes" { 

        monitor::port { "postgresql_${postgresql::params::protocol}_${postgresql::params::port}": 
            enable   => "false",
            tool     => "${monitor_tool}",
        }

        monitor::process { "postgresql_process":
            enable   => "false",
            tool     => "${monitor_tool}",
        }

    }

}
