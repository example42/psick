# Class: clamav
#
# Manages clamav.
# Include it to install and run clamav with default settings
#
# Usage:
# include clamav


import "defines/*.pp"
import "classes/*.pp"

class clamav {

        package { clamav:
                name   => $operatingsystem ? {
                        default => "clamav",
                        },
                ensure => present,
        }

        package { clamav-data:
                name   => $operatingsystem ? {
                        default => "clamav-data",
                        },
                ensure => present,
        }

        package { clamav-freshclam:
                name   => $operatingsystem ? {
                        redhat  => "clamav-update",
                        centos  => "clamav-update",
                        default => "clamav-freshclam",
                        },
                ensure => present,
        }

        package { clamav-daemon:
                name   => $operatingsystem ? {
                        redhat  => "clamav-server",
                        centos  => "clamav-server",
                        default => "clamav-daemon",
                        },
                ensure => present,
        }

# Extra settings per Operating system 
        case $operatingsystem {
                centos: { clamav::instance { "default": } }
                redhat: { clamav::instance { "default": } }
                default: { }
        }

# Inclusion of optional extended classes
	if $backup == "yes" { include clamav::backup }
	if $monitor == "yes" { include clamav::monitor }
	if $firewall == "yes" { include clamav::firewall }

}
