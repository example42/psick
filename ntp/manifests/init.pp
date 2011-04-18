#
# Class: ntp
#
# Manages ntp.
# Include it to install and run ntp
# It defines package, service, main configuration file.
#
# Usage:
# include ntp
#
class ntp {

    # Load the variables used in this module. Check the params.pp file 
    require ntp::params

    # Basic Package - Service - Configuration file management
    package { "ntp":
        name   => "${ntp::params::packagename}",
        ensure => present,
    }

    service { "ntp":
        name       => "${ntp::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${ntp::params::hasstatus}",
        pattern    => "${ntp::params::processname}",
        require    => Package["ntp"],
        subscribe  => File["ntp.conf"],
    }

    file { "ntp.conf":
        path    => "${ntp::params::configfile}",
        mode    => "${ntp::params::configfile_mode}",
        owner   => "${ntp::params::configfile_owner}",
        group   => "${ntp::params::configfile_group}",
        ensure  => present,
        require => Package["ntp"],
        notify  => Service["ntp"],
        # content => template("ntp/ntp.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "ntp::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include ntp::puppi }
    if $backup == "yes" { include ntp::backup }
    if $monitor == "yes" { include ntp::monitor }
    if $firewall == "yes" { include ntp::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include ntp::debug }

}
