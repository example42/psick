#
# Class: activemq
#
# Manages activemq.
# Include it to install and run activemq
# It defines package, service, main configuration file.
#
# Usage:
# include activemq
#
class activemq {

    # Load the variables used in this module. Check the params.pp file 
    require activemq::params
    require mcollective::params

    # Basic Package - Service - Configuration file management
    package { "activemq":
        name   => "${activemq::params::packagename}",
        ensure => present,
    }

    service { "activemq":
        name       => "${activemq::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${activemq::params::hasstatus}",
        pattern    => "${activemq::params::processname}",
        require    => Package["activemq"],
        subscribe  => File["activemq.conf"],
    }

    file { "activemq.conf":
        path    => "${activemq::params::configfile}",
        mode    => "${activemq::params::configfile_mode}",
        owner   => "${activemq::params::configfile_owner}",
        group   => "${activemq::params::configfile_group}",
        ensure  => present,
        require => Package["activemq"],
        notify  => Service["activemq"],
        content => template("activemq/activemq.xml.erb"), # Single node activemq setup
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        redhat,centos: { include activemq::redhat }
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include activemq::backup }
    if $monitor == "yes" { include activemq::monitor }
    if $firewall == "yes" { include activemq::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in activemq module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::activemq" }
            default: { include "activemq::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include activemq::debug }

}
