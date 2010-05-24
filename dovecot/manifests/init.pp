# Class: dovecot
#
# Manages dovecot.
# Include it to install and run dovecot with default settings
#
# Usage:
# include dovecot
#
class dovecot {

    # Load the variables used in this module. Check the params.pp file
    require dovecot::params

    # Basic Package - Service - Configuration file management
    package { postfix:
        name   => "${dovecot::params::packagename}",
        ensure => present,
    }

    service { "dovecot":
        name       => "${dovecot::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["dovecot"],
        subscribe  => File["dovecot.conf"],
    }

    file { "dovecot.conf":
        path    => "${dovecot::params::configfile}",
        mode    => "${dovecot::params::configfile_mode}",
        owner   => "${dovecot::params::configfile_owner}",
        group   => "${dovecot::params::configfile_group}",
        require => Package[dovecot],
        ensure  => present,
    }


    case $operatingsystem {
        debian: { include dovecot::debian }
        ubuntu: { include dovecot::debian }
        default: { }
    }

    if $backup == "yes" { include dovecot::backup }
    if $monitor == "yes" { include dovecot::monitor }
    if $firewall == "yes" { include dovecot::firewall }

}
