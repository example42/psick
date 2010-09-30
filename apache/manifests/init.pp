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
        hasstatus  => "${apache::params::hasstatus}",
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

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in apache module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::apache" }
            default: { include "apache::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include apache::debug }

}
