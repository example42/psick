#
# Class: squid
#
# Manages squid.
# Include it to install and run squid
# It defines package, service, main configuration file.
#
# Usage:
# include squid
#
class squid {

    # Load the variables used in this module. Check the params.pp file 
    require squid::params

    # Re-sets variables needed in templates (to get default values)
    $squid_server = $squid::params::server

    # Basic Package - Service - Configuration file management
    package { "squid":
        name   => "${squid::params::packagename}",
        ensure => present,
    }

    service { "squid":
        name       => "${squid::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${squid::params::hasstatus}",
        pattern    => "${squid::params::processname}",
        require    => Package["squid"],
        subscribe  => File["squid.conf"],
    }

    file { "squid.conf":
        path    => "${squid::params::configfile}",
        mode    => "${squid::params::configfile_mode}",
        owner   => "${squid::params::configfile_owner}",
        group   => "${squid::params::configfile_group}",
        ensure  => present,
        require => Package["squid"],
        notify  => Service["squid"],
        content => template("squid/squid.conf.erb"),
    }

    file { "cache_dir":
        path   => "${squid::params::cache_dir}",
        mode   => "755",
        owner  => "${squid::params::processuser}",
        group  => "${squid::params::configfile_group}",
        ensure => directory,
    }

    file { "cache_log_dir":
        path   => "${squid::params::cache_log_dir}",
        mode   => "640",
        owner  => "${squid::params::processuser}",
        group  => "${squid::params::processuser}",
        ensure => directory,
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes
    if $puppi == "yes" { include squid::puppi }
    if $backup == "yes" { include squid::backup }
    if $monitor == "yes" { include squid::monitor }
    if $firewall == "yes" { include squid::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "squid::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include squid::debug }

}
