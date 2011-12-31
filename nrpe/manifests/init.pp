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

    # NRPE is useless without Nagios plugins
    include nagios::plugins

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

    # Include extra configs for Example42 Nagios/Nrpe implementation
    include nrpe::extra

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        debian,ubuntu: { include nrpe::debian }
        redhat,centos: { include nrpe::redhat }
        default: { }
    }

    # Include extended classes  
    if $puppi == "yes" { include nrpe::puppi }
    if $backup == "yes" { include nrpe::backup }
    if $monitor == "yes" { include nrpe::monitor }
    if $firewall == "yes" { include nrpe::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "nrpe::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nrpe::debug }

}
