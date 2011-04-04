#
# Class: openvpn
#
# Manages openvpn.
# Include it to install and run openvpn
# It defines package, service, main configuration file.
#
# Usage:
# include openvpn
#
class openvpn {

    # Load the variables used in this module. Check the params.pp file 
    require openvpn::params

    # Basic Package - Service - Configuration file management
    package { "openvpn":
        name   => "${openvpn::params::packagename}",
        ensure => present,
    }

    service { "openvpn":
        name       => "${openvpn::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${openvpn::params::hasstatus}",
        pattern    => "${openvpn::params::processname}",
        require    => Package["openvpn"],
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include openvpn::puppi }
    if $backup == "yes" { include openvpn::backup }
    if $monitor == "yes" { include openvpn::monitor }
    if $firewall == "yes" { include openvpn::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in openvpn module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::openvpn" }
            default: { include "openvpn::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openvpn::debug }

}
