#
# Class: rsyslog::server
#
# Manages rsyslog server
#
# Usage:
# Automatically included when you include rsyslog if $syslog_server_local is true or $syslog_server is equal to $fqdn
#
class rsyslog::server inherits rsyslog {

    # Load the variables used in this module. Check the params.pp file 
    require rsyslog::params

    # Configure mysql support, if requested
    if ( $rsyslog::params::db == "mysql" ) { include rsyslog::server::mysql }

    # Add LogAnalyzer
    if ( $rsyslog::params::use_loganalyzer == "yes" ) { include rsyslog::server::loganalyzer }

    file { "rsyslog.init":
        path    => "${rsyslog::params::initconfigfile}",
        mode    => "${rsyslog::params::configfile_mode}",
        owner   => "${rsyslog::params::configfile_owner}",
        group   => "${rsyslog::params::configfile_group}",
        ensure  => present,
        require => Package["rsyslog"],
        notify  => Service["rsyslog"],
        content => $operatingsystem ? {
            ubuntu  => template("rsyslog/rsyslog-init-ubuntu.erb"),
            debian  => template("rsyslog/rsyslog-init-debian.erb"),
            default => template("rsyslog/rsyslog-init-redhat.erb"),
        }
    }

    File["rsyslog.conf"] {
        content => template("rsyslog/server/rsyslog.conf.erb"),
    }

    # Autofirewalling for syslog server
    if $firewall == "yes" { include rsyslog::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "rsyslog::${my_project}::server" }

}
