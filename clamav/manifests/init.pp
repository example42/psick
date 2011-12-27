# Class: clamav
#
# Manages clamav.
# Include it to install and run clamav with default settings
#
# Usage:
# include clamav
#
class clamav {

    require clamav::params

    package { clamav:
        name   => "${clamav::params::packagename}",
        ensure => present,
    }

    package { clamav-data:
        name   => "${clamav::params::packagename_data}",
        ensure => present,
    }

    package { clamav-freshclam:
        name   => "${clamav::params::packagename_freshclam}",
        ensure => present,
    }

    package { clamav-daemon:
        name   => "${clamav::params::packagename_daemon}",
        ensure => present,
    }


# Extra settings per Operating system 
    case $operatingsystem {
        centos: { clamav::instance { "default": } }
        redhat: { clamav::instance { "default": } }
        default: { }
    }

# Inclusion of optional extended classes
#    if $backup == "yes" { include clamav::backup }
#    if $monitor == "yes" { include clamav::monitor }
#    if $firewall == "yes" { include clamav::firewall }

}
