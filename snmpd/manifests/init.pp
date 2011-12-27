#
# Class: snmpd
#
# Manages snmpd.
# Include it to install and run snmpd
# It defines package, service, main configuration file.
#
# Usage:
# include snmpd
#
class snmpd {

    # Load the variables used in this module. Check the params.pp file 
    require snmpd::params

    # Basic Package - Service - Configuration file management
    package { "snmpd":
        name   => "${snmpd::params::packagename}",
        ensure => present,
    }

    service { "snmpd":
        name       => "${snmpd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${snmpd::params::hasstatus}",
        pattern    => "${snmpd::params::processname}",
        require    => Package["snmpd"],
        subscribe  => File["snmpd.conf"],
    }

    file { "snmpd.conf":
        path    => "${snmpd::params::configfile}",
        mode    => "${snmpd::params::configfile_mode}",
        owner   => "${snmpd::params::configfile_owner}",
        group   => "${snmpd::params::configfile_group}",
        ensure  => present,
        require => Package["snmpd"],
        notify  => Service["snmpd"],
        # content => template("snmpd/snmpd.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include snmpd::backup }
    if $monitor == "yes" { include snmpd::monitor }
    if $firewall == "yes" { include snmpd::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "snmpd::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include snmpd::debug }

}
