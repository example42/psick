# Class: clamav::server
#
# Clamav server class. Runs service, defines main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
#
class clamav::server {

    service { clamav:
        name => $operatingsystem ? {
            default => "clamav",
            },
        ensure => running,
        enable => true,
        pattern => $operatingsystem ? {
            default => "/usr/sbin/clamav",
            },
        hasrestart => true,
        hasstatus => true,
        require => Package["clamav-daemon"],
        subscribe => File["clamav.conf"],
    }

    file { "clamav.conf":
#        mode => 644, owner => root, group => root,
        require => Package[clamav-daemon],
        ensure => present,
        path => $operatingsystem ?{
                   default => "/etc/clamav/clamav.conf",
        },
    }
}

