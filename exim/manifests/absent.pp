# Class: exim::absent
#
# Removes exim
#
# Usage:
# include exim::absent
#
class exim::absent {

    # Load the variables used in this module. Check the params.pp file
    require exim::params

    # Basic Package - Service - Configuration file management
    package { exim:
        name   => "${exim::params::packagename}",
        ensure => absent,
    }

    file { "exim.conf":
        path    => "${exim::params::configfile}",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        ensure  => absent,
    }

}
