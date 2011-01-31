#
# Class: samba
#
# Manages samba.
# Include it to install and run samba
# It defines package, service, main configuration file.
#
# Usage:
# include samba
#
class samba {

    # Load the variables used in this module. Check the params.pp file 
    require samba::params

    # Basic Package - Service - Configuration file management
    package { "samba":
        name   => "${samba::params::packagename}",
        ensure => present,
    }

    service { "samba":
        name       => "${samba::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${samba::params::hasstatus}",
        pattern    => "${samba::params::processname}",
        require    => Package["samba"],
        subscribe  => File["samba.conf"],
    }

    file { "samba.conf":
        path    => "${samba::params::configfile}",
        mode    => "${samba::params::configfile_mode}",
        owner   => "${samba::params::configfile_owner}",
        group   => "${samba::params::configfile_group}",
        ensure  => present,
        require => Package["samba"],
        notify  => Service["samba"],
        # content => template("samba/samba.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include samba::backup }
    if $monitor == "yes" { include samba::monitor }
    if $firewall == "yes" { include samba::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in samba module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::samba" }
            default: { include "samba::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include samba::debug }

}
