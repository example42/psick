#
# Class: dovecot
#
# Manages dovecot.
# Include it to install and run dovecot
# It defines package, service, main configuration file.
#
# Usage:
# include dovecot
#
class dovecot {

    # Load the variables used in this module. Check the params.pp file 
    require dovecot::params

    # Basic Package - Service - Configuration file management
    package { "dovecot":
        name   => "${dovecot::params::packagename}",
        ensure => present,
    }

    service { "dovecot":
        name       => "${dovecot::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${dovecot::params::hasstatus}",
        pattern    => "${dovecot::params::processname}",
        require    => Package["dovecot"],
        subscribe  => File["dovecot.conf"],
    }

    file { "dovecot.conf":
        path    => "${dovecot::params::configfile}",
        mode    => "${dovecot::params::configfile_mode}",
        owner   => "${dovecot::params::configfile_owner}",
        group   => "${dovecot::params::configfile_group}",
        ensure  => present,
        require => Package["dovecot"],
        notify  => Service["dovecot"],
        # content => template("dovecot/dovecot.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        debian: { include dovecot::debian }
        ubuntu: { include dovecot::debian }
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include dovecot::backup }
    if $monitor == "yes" { include dovecot::monitor }
    if $firewall == "yes" { include dovecot::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "dovecot::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dovecot::debug }

}
