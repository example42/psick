#
# Class: puppet::client
#
# Manages puppet client
# Include it to install and run puppet with default settings
# It defines package, service, main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
#
# Usage:
# Automatically included when you include puppet
#
class puppet::client {

    # Load the variables used in this module. Check the params.pp file 
    require puppet::params

    # Resets variables needed in templates (to get default values)
    $puppet_server = $puppet::params::server
    $puppet_allow = $puppet::params::allow
    $puppet_version = $puppet::params::version

    file { "puppet.conf":
        path    => "${puppet::params::configfile}",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package[puppet],
        ensure  => present,
        content => template("puppet/client/puppet.conf.erb"),
        notify  => Service["puppet"],
    }

    file {
        "namespaceauth.conf":
        path    => "${puppet::params::configdir}/namespaceauth.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package[puppet],
        ensure  => present,
        content => template("puppet/client/namespaceauth.conf.erb"),
        notify  => Service["puppet"],
    }


    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        ubuntu: { include puppet::ubuntu }
        default: { }
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "puppet::${my_project}::client" }

}
