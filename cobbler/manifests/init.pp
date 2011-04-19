#
# Class: cobbler
#
# Manages cobbler.
# Include it to install and run cobbler
# It defines package, service, main configuration file.
#
# Usage:
# include cobbler
#
class cobbler {

    # Load the variables used in this module. Check the params.pp file 
    require cobbler::params

    # Basic Package - Service - Configuration file management
    package { "cobbler":
        name   => "${cobbler::params::packagename}",
        ensure => present,
    }

    service { "cobbler":
        name       => "${cobbler::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${cobbler::params::hasstatus}",
        pattern    => "${cobbler::params::processname}",
        require    => Package["cobbler"],
        subscribe  => File["cobbler.conf"],
    }

    file { "cobbler.conf":
        path    => "${cobbler::params::configfile}",
        mode    => "${cobbler::params::configfile_mode}",
        owner   => "${cobbler::params::configfile_owner}",
        group   => "${cobbler::params::configfile_group}",
        ensure  => present,
        require => Package["cobbler"],
        notify  => Service["cobbler"],
        # content => template("cobbler/cobbler.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "cobbler::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include cobbler::puppi }
    if $backup == "yes" { include cobbler::backup }
    if $monitor == "yes" { include cobbler::monitor }
    if $firewall == "yes" { include cobbler::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include cobbler::debug }

}
