#
# Class: puppet
#
# Manages puppet.
# Include it to install and run puppet
# It defines package, service, main configuration file.
#
# Usage:
# include puppet
#
class puppet {

    # Load the variables used in this module. Check the params.pp file 
    require puppet::params

    # Autoloads puppet::master if $puppet_server_local is true or $puppet_server is equal to $fqdn
    if ($puppet_server_local == true) or ($puppet_server == "$fqdn") { include puppet::server }
    else { include puppet::client }

    # Basic Package - Service - Configuration file management is done on sub classess client and server
    package { puppet:
        name   => "${puppet::params::packagename}",
        ensure => present,
    }

    service { puppet:
        name       => "${puppet::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        pattern    => "${puppet::params::processname}",
        hasstatus  => "${puppet::params::hasstatus}",
        require    => Package["puppet"],
        subscribe  => File["puppet.conf"],
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        ubuntu: { include puppet::ubuntu }
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "puppet::${my_project}" }

    # Include extended classes
    if $puppi == "yes" { include puppet::puppi }
    if $backup == "yes" { include puppet::backup }
    if $monitor == "yes" { include puppet::monitor }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include puppet::debug }

}
