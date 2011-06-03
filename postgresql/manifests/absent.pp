# Class: postgresql::absent
#
# Removes postgresql package
# Note that by default it doesn't remove other resources eventually
# added by the base class.
#
# Usage:
# include postgresql::absent
#
class postgresql::absent {

    require postgresql::params

    package { "postgresql":
        name   => "${postgresql::params::packagename}",
        ensure => absent,
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
