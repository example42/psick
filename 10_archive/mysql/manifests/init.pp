# Class: mysql
#
# Manages mysql.
# Include it to install and run mysql with default settings
#
# Usage:
# include mysql


import "defines/*.pp"
import "classes/*.pp"

class mysql {

    package { "mysql":
        name   => $operatingsystem ? {
            ubuntu  => "mysql-client",
            debian  => "mysql-client",
            default => "mysql",
            },
        ensure => present,
    }

    package { "mysql-server":
        name   => $operatingsystem ? {
            default => "mysql-server",
            },
        ensure => present,
    }

    service { "mysql":
        name => $operatingsystem ? {
            redhat  => "mysqld",
            centos  => "mysqld",
            default => "mysql",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["mysql-server"],
        subscribe => File["my.cnf"],
    }

    file { "my.cnf":
#           mode => 644, owner => root, group => root,
        require => Package["mysql-server"],
        ensure => present,
        path => $operatingsystem ?{
            default => "/etc/my.cnf",
        },
    }


# Extra settings per Operating system 
    case $operatingsystem {
        default: { }
    }

# Inclusion of optional extended classes
    if $backup == "yes" { include mysql::backup }
    if $monitor == "yes" { include mysql::monitor }
    if $firewall == "yes" { include mysql::firewall }

}
