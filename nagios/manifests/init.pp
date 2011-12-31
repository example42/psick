#
# Class: nagios
#
# Manages nagios.
# Include it to install and run nagios
# It defines package, service, main configuration file.
#
# Usage:
# include nagios
#
class nagios {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params
    include apache::params

    # No Nagios without webserver
    include apache

    # Basic Package - Service - Configuration file management
    package { "nagios":
        name   => "${nagios::params::packagename}",
        ensure => present,
    }

    service { "nagios":
        name       => "${nagios::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${nagios::params::hasstatus}",
        pattern    => "${nagios::params::processname}",
        require    => Package["nagios"],
        subscribe  => File["nagios.conf"],
    }

    file { "nagios.conf":
        path    => "${nagios::params::configfile}",
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => Package["nagios"],
        notify  => Service["nagios"],
        content => template("nagios/nagios.cfg.erb"),
    }

    # Include extra configs for Example42 Nagios implementation
    include nagios::extra

    # Include cleanup class that can be used to clean and purge storeconfigured mess
    include nagios::cleanup

    # Manage permissions on external command file, is used (needed for CGI commands)
    if "${nagios::params::check_external_commands}" == "yes" {

        file { "nagios.cmd_dir":
            path    => "${nagios::params::commanddir}",
            mode    => "750",
            owner   => "${nagios::params::username}",
            group   => "${apache::params::username}",
            ensure  => present,
            require => Package["nagios"],
        }

        file { "nagios.cmd":
            path    => "${nagios::params::commandfile}",
            mode    => "660",
            owner   => "${nagios::params::username}",
            group   => "${apache::params::username}",
            ensure  => present,
            require => Package["nagios"],
            notify  => Service["nagios"],
        }
    }

    # Collects all the stored configs regarding nagios 
    # If nagios_grouplogic is defined different Nagios server collect the relevant data
    case $nagios::params::grouptag {
        "": {
        File <<| tag == "nagios_host" |>>
        File <<| tag == "nagios_service" |>>
#       File <<| tag == "nagios_hostgroup" |>>
        }
        default: {
        File <<| tag == "nagios_host_$nagios::params::grouptag" |>>
        File <<| tag == "nagios_service_$nagios::params::grouptag" |>>
#       File <<| tag == "nagios_hostgroup_$nagios::params::grouptag" |>>
        }
    }


    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if relevant variables are set
    if $link == "yes" { include nagios::link }
    if $backup == "yes" { include nagios::backup }
    if $monitor == "yes" { include nagios::monitor }
    if $firewall == "yes" { include nagios::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "nagios::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include nagios::debug }

}
