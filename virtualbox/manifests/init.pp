#
# Class: virtualbox
#
# Manages virtualbox.
# Include it to install and run virtualbox
# It defines package, service, main configuration file.
#
# Usage:
# include virtualbox
#
class virtualbox {

    # Load the variables used in this module. Check the params.pp file 
    require virtualbox::params

    # Virtualbox is installed with official repositories
    require virtualbox::repo

    # Basic Package - Service - Configuration file management
    package { "virtualbox":
        name    => "${virtualbox::params::packagename}",
        ensure  => present,
        require => Class["virtualbox::repo"],
    }

    service { "virtualbox":
        name       => "${virtualbox::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${virtualbox::params::hasstatus}",
        pattern    => "${virtualbox::params::processname}",
        require    => Package["virtualbox"],
        subscribe  => File["virtualbox.conf"],
    }

    service { "virtualbox_web":
        name       => "${virtualbox::params::servicename_web}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => false,
        pattern    => "${virtualbox::params::processname_web}",
        require    => Package["virtualbox"],
        subscribe  => File["virtualbox.conf"],
    }

    file { "virtualbox.conf":
        path    => "${virtualbox::params::configfile}",
        mode    => "${virtualbox::params::configfile_mode}",
        owner   => "${virtualbox::params::configfile_owner}",
        group   => "${virtualbox::params::configfile_group}",
        ensure  => present,
#        require => Package["virtualbox"],
        notify  => Service["virtualbox"],
        # content => template("virtualbox/virtualbox.conf.erb"),
    }

    # Include project specific class if $my_project is set
    if $my_project { include "virtualbox::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include virtualbox::puppi }
    if $backup == "yes" { include virtualbox::backup }
    if $monitor == "yes" { include virtualbox::monitor }
    if $firewall == "yes" { include virtualbox::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include virtualbox::debug }

}
