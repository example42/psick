#
# Class: nagios::extra
#
# Some extra stuff necessary for Example42 Nagios implementation
# Needed to make things go smoothly 
#
# Usage:
# Autoincluded by nagios class
#
class nagios::extra {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params

    file { "nagios_configdir_hosts":
        path    => "${nagios::params::configdir}/hosts",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => Package["nagios"],
    }

    file { "nagios_configdir_services":
        path    => "${nagios::params::configdir}/services",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => Package["nagios"],
    }

}
