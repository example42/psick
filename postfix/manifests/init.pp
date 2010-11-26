#
# Class: postfix
#
# Manages postfix.
# Include it to install and run postfix
# It defines package, service, main configuration file.
#
# Usage:
# include postfix
#
class postfix {

    # Load the variables used in this module. Check the params.pp file 
    require postfix::params

    # Basic Package - Service - Configuration file management
    package { "postfix":
        name   => "${postfix::params::packagename}",
        ensure => present,
    }

    service { "postfix":
        name       => "${postfix::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${postfix::params::hasstatus}",
        pattern    => "${postfix::params::processname}",
        require    => Package["postfix"],
        subscribe  => File["main.cf"],
    }

    file { "main.cf":
        path    => "${postfix::params::configfile}",
        mode    => "${postfix::params::configfile_mode}",
        owner   => "${postfix::params::configfile_owner}",
        group   => "${postfix::params::configfile_group}",
        ensure  => present,
        require => Package["postfix"],
        notify  => Service["postfix"],
        # content => template("postfix/postfix.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include postfix::backup }
    if $monitor == "yes" { include postfix::monitor }
    if $firewall == "yes" { include postfix::firewall }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in postfix module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::postfix" }
            default: { include "postfix::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include postfix::debug }

}
