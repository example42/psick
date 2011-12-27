#
# Class: varnish
#
# Manages varnish.
# Include it to install and run varnish
# It defines package, service, main configuration file.
#
# Usage:
# include varnish
#
class varnish {

    # Load the variables used in this module. Check the params.pp file 
    require varnish::params

    # Basic Package - Service - Configuration file management
    package { "varnish":
        name   => "${varnish::params::packagename}",
        ensure => present,
    }

    service { "varnish":
        name       => "${varnish::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${varnish::params::hasstatus}",
        pattern    => "${varnish::params::processname}",
        require    => Package["varnish"],
        subscribe  => File["varnish.conf"],
    }

    file { "varnish.conf":
        path    => "${varnish::params::configfile}",
        mode    => "${varnish::params::configfile_mode}",
        owner   => "${varnish::params::configfile_owner}",
        group   => "${varnish::params::configfile_group}",
        ensure  => present,
        require => Package["varnish"],
        notify  => Service["varnish"],
        content => template("varnish/default.vcl.erb"),
    }

    file { "varnish.initconf":
        path    => "${varnish::params::initconfigfile}",
        mode    => "${varnish::params::configfile_mode}",
        owner   => "${varnish::params::configfile_owner}",
        group   => "${varnish::params::configfile_group}",
        ensure  => present,
        require => Package["varnish"],
        notify  => Service["varnish"],
        content => template("varnish/varnish.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include varnish::backup }
    if $monitor == "yes" { include varnish::monitor }
    if $firewall == "yes" { include varnish::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "varnish::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include varnish::debug }

}
