#
# Class: portmap
#
# Manages portmap.
# Include it to install and run portmap
# It defines package, service, main configuration file.
#
# Usage:
# include portmap
#
class portmap {

    # Load the variables used in this module. Check the params.pp file 
    require portmap::params

    # Basic Package - Service - Configuration file management
    package { "portmap":
        name   => "${portmap::params::packagename}",
        ensure => present,
    }

    service { "portmap":
        name       => "${portmap::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${portmap::params::hasstatus}",
        pattern    => "${portmap::params::processname}",
        require    => Package["portmap"],
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "portmap::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include portmap::puppi }
    if $backup == "yes" { include portmap::backup }
    if $monitor == "yes" { include portmap::monitor }
    if $firewall == "yes" { include portmap::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include portmap::debug }

}
