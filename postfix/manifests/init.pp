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
        # content => template("postfix/postfix.conf.erb"),
    }


    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        redhat: { include sendmail::disable }
        centos: { include sendmail::disable }
        debian: { include exim::disable }
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "postfix::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include postfix::puppi }
    if $backup == "yes" { include postfix::backup }
    if $monitor == "yes" { include postfix::monitor }
    if $firewall == "yes" { include postfix::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include postfix::debug }

}
