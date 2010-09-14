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
        hasstatus  => false,
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

    if $backup == "yes" { include openssh::backup }
    if $monitor == "yes" { include openssh::monitor }
    if $firewall == "yes" { include openssh::firewall }

    case $operatingsystem {
        default: { }
    }

    # Autoloads openssh::$my_project if $my_project is defined
    if $my_project { include "openssh::${my_project}" }

}
