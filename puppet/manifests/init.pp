#
# Class: puppet
#
# Manages puppet.
# Include it to install and run puppet with default settings
# It defines package, service, main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
#
# Usage:
# include puppet
#
class puppet {

    # Load the variables used in this module. Check the params.pp file 
    require puppet::params

    # Basic Package - Service - Configuration file management
    package { puppet:
        name   => "${puppet::params::packagename}",
        ensure => present,
    }

    service { puppet:
        name => "${puppet::params::servicename}",
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["puppet"],
        subscribe => File["puppet.conf"],
    }

    file { "puppet.conf":
        path    => "${puppet::params::configfile}",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package[puppet],
        ensure  => present,
        content => $puppet_server ?{
            $fqdn     => template("puppet/master/puppet.conf.erb"),
            default   => template("puppet/puppet.conf.erb"),
        },
    }

    file {
        "namespaceauth.conf":
        path    => "${puppet::params::configdir}/namespaceauth.conf",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        require => Package[puppet],
        ensure  => present,
        content => $puppet_server ?{
            $fqdn     => template("puppet/master/namespaceauth.conf.erb"),
            default   => template("puppet/namespaceauth.conf.erb"),
        },
#       notify  => Service["puppet"],
    }


    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes
    if $backup == "yes" { include puppet::backup }
    if $monitor == "yes" { include puppet::monitor }
    if $firewall == "yes" { include puppet::firewall }

}
