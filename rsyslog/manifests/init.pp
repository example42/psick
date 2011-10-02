#
# Class: rsyslog
#
# Manages rsyslog.
# Include it to install and run rsyslog
# It defines package, service, main configuration file.
#
# Usage:
# include rsyslog
#
class rsyslog {

    # Load the variables used in this module. Check the params.pp file 
    require rsyslog::params
    require common

    if ($syslog_server_local == true) or ($syslog_server == "$fqdn") { include rsyslog::server }
    else { include rsyslog::client }


    # Basic Package - Service - Configuration file management
    package { "rsyslog":
        name   => "${rsyslog::params::packagename}",
        ensure => present,
    }

    service { "rsyslog":
        name       => "${rsyslog::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${rsyslog::params::hasstatus}",
        pattern    => "${rsyslog::params::processname}",
        require    => Package["rsyslog"],
        subscribe  => File["rsyslog.conf"],
    }

    file { "rsyslog.conf":
        path    => "${rsyslog::params::configfile}",
        mode    => "${rsyslog::params::configfile_mode}",
        owner   => "${rsyslog::params::configfile_owner}",
        group   => "${rsyslog::params::configfile_group}",
        ensure  => present,
        require => Package["rsyslog"],
        notify  => Service["rsyslog"],
        # content => template("rsyslog/rsyslog.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        centos: { if $common::osver == 5 { require sysklogd::disable } }
        redhat: { require sysklogd::disable }
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include rsyslog::backup }
    if $monitor == "yes" { include rsyslog::monitor }

    # Include project specific class if $my_project is set
    # The extra project class is by default looked in rsyslog module 
    # If $my_project_onmodule == yes it's looked in your project module
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::rsyslog" }
            default: { include "rsyslog::${my_project}" }
        }
    }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include rsyslog::debug }

}
