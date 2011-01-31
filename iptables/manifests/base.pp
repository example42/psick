#
# Class: iptables
#
# Manages iptables.
# Include it to install and run iptables
# It defines package, service, main configuration file.
#
# Usage:
# include iptables
#
class iptables::base {

    # Load the variables used in this module. Check the params.pp file 
    require iptables::params

    # Basic Package - Service - Configuration file management
    package { "iptables":
        name   => "${iptables::params::packagename}",
        ensure => present,
    }

    service { "iptables":
        name       => "${iptables::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => false,
        restart    => inline_template("iptables-restore < <%= scope.lookupvar('iptables::params::configfile') %>"),
        hasstatus  => "${iptables::params::hasstatus}",
        require    => Package["iptables"],
    }

    # How to manage iptables configuration
    case $iptables::params::config {
        "file": { include iptables::file }
        "concat": { include iptables::concat }
    }

    case $operatingsystem {
        debian: { include iptables::debian }
        ubuntu: { include iptables::debian }
        default: { }
    }

    # Include extended classes, if relevant variables are defined
    if $monitor == "yes" { include iptables::monitor }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in iptables module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::iptables" }
            default: { include "iptables::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include iptables::debug }

}
