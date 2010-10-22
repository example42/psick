#
# Class: nagios
#
# Manages nagios.
# Include it to install and run nagios
# It defines package, service, main configuration file.
#
# Usage:
# include nagios
#
class nagios {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params

    # Basic Package - Service - Configuration file management
    package { "nagios":
        name   => "${nagios::params::packagename}",
        ensure => present,
    }

    service { "nagios":
        name       => "${nagios::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${nagios::params::hasstatus}",
        pattern    => "${nagios::params::processname}",
        require    => Package["nagios"],
        subscribe  => File["nagios.conf"],
    }

    file { "nagios.conf":
        path    => "${nagios::params::configfile}",
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => Package["nagios"],
        notify  => Service["nagios"],
        # content => template("nagios/nagios.cfg.erb"),
    }

    # Include extra configs for Example42 Nagios implementation
    include nagios::extra

    # Collects all the stored configs regarding nagios
    File <<| tag == 'nagios' |>>

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include nagios::backup }
    if $monitor == "yes" { include nagios::monitor }
    if $firewall == "yes" { include nagios::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in nagios module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::nagios" }
            default: { include "nagios::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nagios::debug }

}
