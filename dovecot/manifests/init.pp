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

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in dovecot module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::dovecot" }
            default: { include "dovecot::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dovecot::debug }

}
