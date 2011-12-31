#
# Class: collectd
#
# Manages collectd.
# Include it to install and run collectd
# It defines package, service, main configuration file.
#
# Usage:
# include collectd
#
class collectd {

    # Load the variables used in this module. Check the params.pp file 
    require collectd::params

    # Basic Package - Service - Configuration file management
    package { "collectd":
        name   => "${collectd::params::packagename}",
        ensure => present,
    }

    service { "collectd":
        name       => "${collectd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${collectd::params::hasstatus}",
        pattern    => "${collectd::params::processname}",
        require    => Package["collectd"],
        subscribe  => File["collectd.conf"],
    }

    file { "collectd.conf":
        path    => "${collectd::params::configfile}",
        mode    => "${collectd::params::configfile_mode}",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        ensure  => present,
        require => Package["collectd"],
        notify  => Service["collectd"],
        content => template("collectd/collectd.conf.erb"),
    }

    file { "collectd.d":
        path    => "${collectd::params::configdir}",
        mode    => "755",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        ensure  => directory,
        require => Package["collectd"],
    }

    # Include plugins
    include collectd::plugins

    # Include collection web interface if on server
    if ($collectd::params::server_local == true) {
        include collectd::collection 
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        redhat: { include collectd::redhat }
        centos: { include collectd::redhat }
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include collectd::backup }
    if $monitor == "yes" { include collectd::monitor }
    if $firewall == "yes" { include collectd::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "collectd::${my_project}::monitor" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include collectd::debug }

}
