# Class: apache
#
# Manages apache.
# Include it to install and run apache with default settings
#
# Usage:
# include apache


import "defines/*.pp"
import "classes/*.pp"

class apache {
    
    require apache::params

    package { apache:
        name   => "${apache::params::packagename}",
        ensure => present,
    }

    service { apache:
        name   => "${apache::params::servicename}",
        ensure => running,
        enable => true,
        pattern => "${apache::params::servicepattern}",
        hasrestart => true,
        hasstatus => true,
        require => Package["apache"],
        subscribe => File["httpd.conf"],
    }

    file { "httpd.conf":
#           mode => 644, owner => root, group => root,
        require => Package[apache],
        ensure => present,
        path => "${apache::params::configfile}",
    }

    case $operatingsystem {
        debian: { include apache::debian }
        ubuntu: { include apache::debian }
        default: { }
    }

    if $backup == "yes" { include apache::backup }
    if $monitor == "yes" { include apache::monitor }
    if $firewall == "yes" { include apache::firewall }

}
