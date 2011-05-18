#
# Class: dhcpd
#
# Manages dhcpd.
# Include it to install and run dhcpd
# It defines package, service, main configuration file.
#
# Usage:
# include dhcpd
#
class dhcpd {

    # Load the variables used in this module. Check the params.pp file 
    require dhcpd::params

    # Basic Package - Service - Configuration file management
    package { "dhcpd":
        name   => "${dhcpd::params::packagename}",
        ensure => present,
    }

    service { "dhcpd":
        name       => "${dhcpd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${dhcpd::params::hasstatus}",
        pattern    => "${dhcpd::params::processname}",
        require    => Package["dhcpd"],
        subscribe  => File["dhcpd.conf"],
    }

    file { "dhcpd.conf":
        path    => "${dhcpd::params::configfile}",
        mode    => "${dhcpd::params::configfile_mode}",
        owner   => "${dhcpd::params::configfile_owner}",
        group   => "${dhcpd::params::configfile_group}",
        ensure  => present,
        require => Package["dhcpd"],
        notify  => Service["dhcpd"],
        # content => template("dhcpd/dhcpd.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "dhcpd::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include dhcpd::puppi }
    if $backup == "yes" { include dhcpd::backup }
    if $monitor == "yes" { include dhcpd::monitor }
    if $firewall == "yes" { include dhcpd::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dhcpd::debug }

}
