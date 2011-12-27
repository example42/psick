# Class: autofs
#
# Manages autofs.
# Include it to install and run autofs with default settings
#
# Usage:
# include autofs
#
class autofs {

    # Load the variables used in this module. Check the params.pp file
    require autofs::params

    # Basic Package - Service - Configuration file management
    package { autofs:
        name   => "${autofs::params::packagename}",
        ensure => present,
    }

    service { "autofs":
        name       => "${autofs::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["autofs"],
        subscribe  => File["autofs.conf"],
    }

    file { "autofs.conf":
        path    => "${autofs::params::configfile}",
        mode    => "${autofs::params::configfile_mode}",
        owner   => "${autofs::params::configfile_owner}",
        group   => "${autofs::params::configfile_group}",
        require => Package[autofs],
        ensure  => present,
    }


    case $operatingsystem {
        default: { }
    }

    if $backup == "yes" { include autofs::backup }
    if $monitor == "yes" { include autofs::monitor }
    if $firewall == "yes" { include autofs::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "autofs::${my_project}" }

}
