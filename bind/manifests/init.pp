#
# Class: bind
#
# Manages bind.
# Include it to install and run bind
# It defines package, service, main configuration file.
#
# Usage:
# include bind
#
class bind {

    # Load the variables used in this module. Check the params.pp file 
    require bind::params

    # Basic Package - Service - Configuration file management
    package { "bind":
        name   => "${bind::params::packagename}",
        ensure => present,
    }

    service { "bind":
        name       => "${bind::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${bind::params::hasstatus}",
        pattern    => "${bind::params::processname}",
        require    => Package["bind"],
    }

    # Bind is a weird beast to manage with Puppet: there can be
    # different approaches to build up named.conf and we don't 
    # want to enforce any.
    # With this module you can manage named.conf in 2 ways:
    # - As a normal configuration file (set $bind_config="file")
    # - As a concatenated file, dynamically built by different parts:
    #   - This is the default choice ($bind_config="concat") and gives the
    #     opportunity to use the bind::zone define to manage custom zones
    case $bind::params::config {
        "file": { include bind::file }
        "concat": { include bind::concat }
    }

    # The log file and dir for Bind
    file { "bind.logdir":
        path    => "${bind::params::logdir}",
        mode    => "755",
        owner   => "${bind::params::user}",
        group   => "${bind::params::user}",
        ensure  => directory,
    }

    file { "bind.log":
        path    => "${bind::params::logdir}/bind.log",
        mode    => "${bind::params::configfile_mode}",
        owner   => "${bind::params::user}",
        group   => "${bind::params::user}",
        ensure  => present,
        require => File["bind.logdir"],
    }

    # The directory where Bind places slave zone files 
    file { "bind.slave.dir":
        path    => "${bind::params::datadir}/slaves",
        mode    => "755",
        owner   => "${bind::params::user}",
        group   => "${bind::params::user}",
        ensure  => directory,
    }

    # The directory where Bind puts stats data 
    file { "bind.data.dir":
        path    => "${bind::params::datadir}/data",
        mode    => "755",
        owner   => "${bind::params::user}",
        group   => "${bind::params::user}",
        ensure  => directory,
    }

    # RedHat doesn't populate bind's datadir with defaults zones
    # We provide these files via Puppet
    case $operatingsystem {
        redhat: { include bind::redhat }
        centos: { include bind::redhat }
        default: { }
    }

    # Include extended classes, if relevant variables are defined
    if $puppi == "yes" { include bind::puppi }
    if $backup == "yes" { include bind::backup }
    if $monitor == "yes" { include bind::monitor }
    if $firewall == "yes" { include bind::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "bind::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include bind::debug }

}
