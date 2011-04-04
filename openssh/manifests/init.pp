# Class: openssh
#
# Manages openssh service 
#
# Usage:
# include openssh
# 
# Variables:
#
class openssh {

    # Load the variables used in this module. Check the params.pp file
    require openssh::params

    # Reassigns variables names for use in templates


    # Basic Package 
    package { "openssh":
        name   => "${openssh::params::packagename}",
        ensure => present,
    }
    
    service { "openssh":
        name       => "${openssh::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${openssh::params::hasstatus}",
        require    => Package["openssh"],
    }

    file { "sshd_config":
        path    => "${openssh::params::configfile}",
        mode    => "${openssh::params::configfile_mode}",
        owner   => "${openssh::params::configfile_owner}",
        group   => "${openssh::params::configfile_group}",
        require => Package["openssh"],
        notify  => Service["openssh"],
        ensure  => present,
    }

    file { "openssh-init":
        path    => "${openssh::params::initconfigfile}",
        mode    => "${openssh::params::configfile_mode}",
        owner   => "${openssh::params::configfile_owner}",
        group   => "${openssh::params::configfile_group}",
        require => Package["openssh"],
        ensure  => present,
    }

    if $puppi == "yes" { include openssh::puppi }
    if $backup == "yes" { include openssh::backup }
    if $monitor == "yes" { include openssh::monitor }
    if $firewall == "yes" { include openssh::firewall }

    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in openssh module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::openssh" }
            default: { include "openssh::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openssh::debug }

}
