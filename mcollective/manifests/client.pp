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

    # Include project specific monitor class if $my_project is set
    if $my_project { include "mcollective::${my_project}::client" }

}
