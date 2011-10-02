#
# Class: exim
#
# Manages exim.
# Include it to install and run exim
# It defines package, service, main configuration file.
#
# Usage:
# include exim
#
class exim {

    # Load the variables used in this module. Check the params.pp file 
    require exim::params

    # Basic Package - Service - Configuration file management
    package { "exim":
        name   => "${exim::params::packagename}",
        ensure => present,
    }

    service { "exim":
        name       => "${exim::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${exim::params::hasstatus}",
        pattern    => "${exim::params::processname}",
        require    => Package["exim"],
        subscribe  => File["exim.conf"],
    }

    file { "exim.conf":
        path    => "${exim::params::configfile}",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        ensure  => present,
        require => Package["exim"],
        notify  => Service["exim"],
        # content => template("exim/exim.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        ubuntu,debian: { include exim::debian }
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "exim::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include exim::puppi }
    if $backup == "yes" { include exim::backup }
    if $monitor == "yes" { include exim::monitor }
    if $firewall == "yes" { include exim::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include exim::debug }

}
