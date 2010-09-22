# Class: apache
#
# Manages apache.
# Include it to install and run apache2 with default settings
#
# Usage:
# include apache


class apache {
    
    require apache::params

    package { "apache":
        name   => "${apache::params::packagename}",
        ensure => present,
    }

    service { "apache":
        name       => "${apache::params::servicename}",
        ensure     => running,
        enable     => true,
        pattern    => "${apache::params::servicepattern}",
        hasrestart => true,
        hasstatus  => false,
        require    => Package["apache"],
        subscribe  => File["httpd.conf"],
    }

    file { "httpd.conf":
        path    => "${apache::params::configfile}",
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package["apache"],
        ensure  => present,
    }

    case $operatingsystem {
        debian: { include apache::debian }
        ubuntu: { include apache::debian }
        default: { }
    }

    if $backup == "yes" { include apache::backup }
    if $monitor == "yes" { include apache::monitor }
    if $firewall == "yes" { include apache::firewall }

# Autoloads apache::$my_project if $my_project is defined
# Place in apache::$my_project your customizatios
    if $my_project { include "apache::${my_project}" }

}
