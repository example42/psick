#
# Class: munin::server
#
# Installs Munin Grapher/Gatherer 
#
# Usage:
# include munin::server
# Autoloads munin::server (The Munin grapher/gatherer) if $munin_server_local is true or $munin_server is equal to $ipaddress
#
class munin::server {

    # Load the variables used in this module. Check the params.pp file 
    require munin::params

    include apache

    package { "munin":
        name   => "${munin::params::packagename_server}",
        ensure => present,
    }

    file { "munin.conf":
        path    => "${munin::params::configfile_server}",
        mode    => "${munin::params::configfile_mode}",
        owner   => "${munin::params::configfile_owner}",
        group   => "${munin::params::configfile_group}",
        ensure  => present,
        require => Package["munin"],
        content => template("munin/munin.conf.erb"),
    }

    file { "munin.includedir":
        path    => "${munin::params::includedir}",
        mode    => "755",
        owner   => "${munin::params::configfile_owner}",
        group   => "${munin::params::configfile_group}",
        ensure  => directory,
        require => Package["munin"],
    }

    # Collects all the stored configs regarding munin
    case $munin::params::grouptag {
        "": {
        File <<| tag == "munin_host" |>>
        }
        default: {
        File <<| tag == "munin_host_$munin::params::grouptag" |>>
        }
    }


    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $link == "yes" { include munin::link }
    if $backup == "yes" { include munin::backup }
    if $monitor == "yes" { include munin::monitor }
    if $firewall == "yes" { include munin::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "munin::${my_project}::server" }

}
