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

    # Resets variables needed in templates (to get default values)
    $puppet_server = $puppet::params::server
    $puppet_allow = $puppet::params::allow
    $puppet_nodetool = $puppet::params::nodetool
    $puppet_externalnodes = $puppet::params::externalnodes
    $puppet_storeconfigs = $puppet::params::storeconfigs
    $puppet_storeconfigs_thin = $puppet::params::storeconfigs_thin
    $puppet_db = $puppet::params::db
    $puppet_db_server = $puppet::params::db_server
    $puppet_db_user = $puppet::params::db_user
    $puppet_db_password = $puppet::params::db_password
    $puppet_version = $puppet::params::version



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

    # Include extended classes
    if $backup == "yes" { include puppet::backup }
    if $monitor == "yes" { include puppet::monitor }
    if $firewall == "yes" { include puppet::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in puppet module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::puppet" }
            default: { include "puppet::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include puppet::debug }

}
