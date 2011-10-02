#
# Class: munin
#
# Manages munin.
# Include it to install and run munin
# It defines package, service, main configuration file.
#
# Usage:
# include munin
#
class munin {

    # Load the variables used in this module. Check the params.pp file 
    require munin::params

    # Autoloads munin::server (The Munin grapher/gatherer) if $munin_server_local is true or $munin_server is equal to $fqdn
    if ($munin::params::server_local == "yes") or ($munin::params::server == "$ipaddress") { include munin::server }


    # We assume that we want munin-node on all the nodes (server included)
    # Basic Package - Service - Configuration file management
    package { "munin-node":
        name   => "${munin::params::packagename}",
        ensure => present,
    }

    package { "libnet-cidr-perl":
        name   => "${munin::params::packagename_perlcidr}",
        ensure => present,
    }

    service { "munin-node":
        name       => "${munin::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${munin::params::hasstatus}",
        pattern    => "${munin::params::processname}",
        require    => Package["munin-node"],
        subscribe  => File["munin-node.conf"],
    }

    file { "munin-node.conf":
        path    => "${munin::params::configfile}",
        mode    => "${munin::params::configfile_mode}",
        owner   => "${munin::params::configfile_owner}",
        group   => "${munin::params::configfile_group}",
        ensure  => present,
        require => Package["munin-node"],
        notify  => Service["munin-node"],
        content => template("munin/munin-node.conf.erb"),
    }

    # For better automation we want plugin autoconfiguration every day
    file { "munin-autoconfigure":
        path    => "/etc/cron.daily/munin-autoconfigure",
        mode    => "755",
        owner   => "root",
        group   => "root",
        ensure  => present,
        require => Package["munin-node"],
        content => template("munin/munin-autoconfigure.erb"),
    }


    @@file { "${munin::params::includedir}/${fqdn}.conf":
        mode    => "${munin::params::configfile_mode}",
        owner   => "${munin::params::configfile_owner}",
        group   => "${munin::params::configfile_group}",
        ensure  => present,
        require => Package["munin"],
        content => template( "munin/host.erb" ),
        tag     => "${munin::params::grouptag}" ? {
            ''       => "munin_host",
            default  => "munin_host_$munin::params::grouptag",
        },
    }

    # Include Extra custom Plugins
    if ( $munin::params::plugins != "no") { include munin::plugins }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes
    if $puppi == "yes" { include munin::puppi }
    if $backup == "yes" { include munin::backup }
    if $monitor == "yes" { include munin::monitor }
    if $firewall == "yes" { include munin::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in munin module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::munin" }
            default: { include "munin::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include munin::debug }

}
