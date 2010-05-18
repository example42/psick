# Class: dovecot
#
# Manages dovecot.
# Include it to install and run dovecot with default settings
#
# Usage:
# include dovecot


import "defines/*.pp"
import "classes/*.pp"

class dovecot {

    package { "dovecot":
        name   => $operatingsystem ? {
            debian  => "dovecot-imapd",
            ubuntu  => "dovecot-imapd",
            default => "dovecot",
            },
        ensure => present,
    }

    service { "dovecot":
        name => $operatingsystem ? {
            default => "dovecot",
            },
        ensure => running,
        enable => true,
        pattern => $operatingsystem ? {
            default => "/usr/sbin/dovecot",
            },
        hasrestart => true,
        hasstatus => true,
        require => Package["dovecot"],
        subscribe => File["dovecot.conf"],
    }

    file { "dovecot.conf":
#           mode => 644, owner => root, group => root,
        require => Package[dovecot],
        ensure => present,
        path => $operatingsystem ?{
            debian  => "/etc/dovecot/dovecot.conf",
            ubuntu  => "/etc/dovecot/dovecot.conf",
            default => "/etc/dovecot.conf",
        },
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
