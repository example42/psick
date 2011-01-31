#
# Class: mcollective::client
#
# Manages mcollective client
# Include it to install mcollective client
#
# Usage:
# Set $mcollective_client=yes and include mcollective to autoload mcollective::client
#
class mcollective::client {

    # Load the variables used in this module. Check the params.pp file 
    require mcollective::params

    # Basic Package - Configuration file management
    package { "mcollective_client":
        name     => "${mcollective::params::packagename_client}",
        ensure   => present,
    }

    file { "mcollective_client.conf":
        path    => "${mcollective::params::configfile_client}",
        mode    => "${mcollective::params::configfile_mode}",
        owner   => "${mcollective::params::configfile_owner}",
        group   => "${mcollective::params::configfile_group}",
        ensure  => present,
        require => Package["mcollective_client"],
        content => template("mcollective/client.cfg.erb"),
    }

    # Include Plugins
    if ( $mcollective::params::plugins != "no") { include mcollective::plugins }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in mcollective module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::mcollective::client" }
            default: { include "mcollective::client::${my_project}" }
        }
    }

}
