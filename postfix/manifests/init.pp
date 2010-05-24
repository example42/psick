#
# Class: postfix
#
# Manages postfix.
# Include it to install and run postfix with default settings
# It defines package, service, main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
#
# Usage:
# include postfix
#
class postfix {

    # Load the variables used in this module. Check the params.pp file 
    require postfix::params

    # Basic Package - Service - Configuration file management
    package { postfix:
        name   => "${postfix::params::packagename}",
        ensure => present,
    }

    service { postfix:
        name => "${postfix::params::servicename}",
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["postfix"],
        subscribe => File["main.cf"],
    }

    file { "main.cf":
        path    => "${postfix::params::configfile}",
        mode    => "${postfix::params::configfile_mode}",
        owner   => "${postfix::params::configfile_owner}",
        group   => "${postfix::params::configfile_group}",
        require => Package[postfix],
        ensure  => present,
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes
    if $backup == "yes" { include postfix::backup }
    if $monitor == "yes" { include postfix::monitor }
    if $firewall == "yes" { include postfix::firewall }

}
