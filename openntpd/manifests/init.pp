# Class: openntpd
#
# Manages openntpd service 
#
# Usage:
# include openntpd
# 
# Variables:
# $ntp_server  (default: [ "0.pool.ntp.org" , "1.pool.ntp.org" ] ) - Defines the ntp servers to use
# $ntp_startup (default: "no" ) - Set the time immediately at startup if the local clock is off by more than 180 seconds (option -s).
#
class openntpd {

    # Load the variables used in this module. Check the params.pp file
    require openntpd::params

    # Reassigns variables names for use in templates
    $ntp_server = $openntpd::params::server
    $ntp_startup = $openntpd::params::startup


    # Basic Package 
    package { "openntpd":
        name   => "${openntpd::params::packagename}",
        ensure => present,
    }
    
    service { "openntpd":
        name       => "${openntpd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => false,
        pattern    => "ntpd",
        require    => Package["openntpd"],
    }

    file { "ntp.conf":
        path    => "${openntpd::params::configfile}",
        mode    => "${openntpd::params::configfile_mode}",
        owner   => "${openntpd::params::configfile_owner}",
        group   => "${openntpd::params::configfile_group}",
        require => Package["openntpd"],
        ensure  => present,
        content => template("openntpd/ntpd.conf.erb"),
    }

    file { "openntpd-init":
        path    => "${openntpd::params::initconfigfile}",
        mode    => "${openntpd::params::configfile_mode}",
        owner   => "${openntpd::params::configfile_owner}",
        group   => "${openntpd::params::configfile_group}",
        require => Package["openntpd"],
        ensure  => present,
        content => $operatingsystem ? {
            debian  => template("openntpd/openntpd_initd-debian.erb"),
            ubuntu  => template("openntpd/openntpd_initd-debian.erb"),
            redhat  => template("openntpd/openntpd_initd-redhat.erb"),
            centos  => template("openntpd/openntpd_initd-redhat.erb"),
        },
    }

# TODO manage openntpd package installation on Centos/RedHat

    if $backup == "yes" { include openntpd::backup }
    if $monitor == "yes" { include openntpd::monitor }
    if $firewall == "yes" { include openntpd::firewall }

    case $operatingsystem {
        default: { }
    }

}
