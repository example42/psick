#
# Class: nagios::plugins
#
# Installs nagios plugins. Needed on hosts with nrpe agent
#
# Usage:
# include nagios::plugins
#
class nagios::plugins {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params

    # Basic Package 
    package { "nagios-plugins":
        name   => "${nagios::params::packagenameplugins}",
        ensure => present,
    }

    # Needed only on the Nagios server
    package { "nagios-plugins-nrpe":
        name   => "${nagios::params::packagenamenrpeplugin}",
        ensure => present,
    }

    # Include Extra custom Plugins (Provided via Puppet)
    if ( $nagios::params::plugins != "no") { 
        nagios::plugin { "check_mount": } 
    }

}
