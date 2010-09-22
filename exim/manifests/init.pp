# Class: exim
#
# Manages exim.
# Include it to install and run exim with default settings
#
# Usage:
# include exim
#
class exim {

    # Load the variables used in this module. Check the params.pp file
    require exim::params

    # Basic Package - Service - Configuration file management
    package { exim:
        name   => "${exim::params::packagename}",
        ensure => present,
    }

    service { "exim":
        name       => "${exim::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["exim"],
        subscribe  => File["exim.conf"],
    }

    file { "exim.conf":
        path    => "${exim::params::configfile}",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        require => Package[exim],
        ensure  => present,
    }

    case $operatingsystem {
        ubuntu,debian: { include exim::debian }
        default: { }
    }

    if $backup == "yes" { include exim::backup }
    if $monitor == "yes" { include exim::monitor }
    if $firewall == "yes" { include exim::firewall }

# Autoloads exim::$my_project if $my_project is defined
# Place in exim::$my_project your customizatios
    if $my_project { include "exim::${my_project}" }

}
