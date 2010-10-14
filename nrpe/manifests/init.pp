#
# Class: nrpe
#
# Manages nrpe.
# Include it to install and run nrpe
# It defines package, service, main configuration file.
#
# Usage:
# include nrpe
#
class nrpe {

    # Load the variables used in this module. Check the params.pp file 
    require nrpe::params

    # Re-sets variables needed in templates (to get default values)
    $nrpe_server = $nrpe::params::server

    # Basic Package - Service - Configuration file management
    package { "nrpe":
        name   => "${nrpe::params::packagename}",
        ensure => present,
    }

    service { "nrpe":
        name       => "${nrpe::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${nrpe::params::hasstatus}",
        pattern    => "${nrpe::params::processname}",
        require    => Package["nrpe"],
        subscribe  => File["nrpe.conf"],
    }

    file { "nrpe.conf":
        path    => "${nrpe::params::configfile}",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => Package["nrpe"],
        notify  => Service["nrpe"],
        content => template("nrpe/nrpe.cfg.erb"),
    }

    file { "nrpe.d":
        path    => "${nrpe::params::configdir}",
        mode    => "755",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => directory,
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        debian,ubuntu: { include nrpe::debian }
        redhat,centos: { include nrpe::redhat }
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include nrpe::backup }
    if $monitor == "yes" { include nrpe::monitor }
    if $firewall == "yes" { include nrpe::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in nrpe module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::nrpe" }
            default: { include "nrpe::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nrpe::debug }

}
