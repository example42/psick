#
# Class: lighttpd
#
# Manages lighttpd.
# Include it to install and run lighttpd
# It defines package, service, main configuration file.
#
# Usage:
# include lighttpd
#
class lighttpd {

    # Load the variables used in this module. Check the params.pp file 
    require lighttpd::params

    # Basic Package - Service - Configuration file management
    package { "lighttpd":
        name   => "${lighttpd::params::packagename}",
        ensure => present,
    }

    service { "lighttpd":
        name       => "${lighttpd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${lighttpd::params::hasstatus}",
        pattern    => "${lighttpd::params::processname}",
        require    => Package["lighttpd"],
        subscribe  => File["lighttpd.conf"],
    }

    file { "lighttpd.conf":
        path    => "${lighttpd::params::configfile}",
        mode    => "${lighttpd::params::configfile_mode}",
        owner   => "${lighttpd::params::configfile_owner}",
        group   => "${lighttpd::params::configfile_group}",
        ensure  => present,
        require => Package["lighttpd"],
        notify  => Service["lighttpd"],
        # content => template("lighttpd/lighttpd.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if relevant variables are defined
    if $backup == "yes" { include lighttpd::backup }
    if $monitor == "yes" { include lighttpd::monitor }
    if $firewall == "yes" { include lighttpd::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "lighttpd::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include lighttpd::debug }

}
