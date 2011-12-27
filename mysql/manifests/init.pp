#
# Class: mysql
#
# Manages mysql.
# Include it to install and run mysql
# It defines package, service, main configuration file.
#
# Usage:
# include mysql
#
class mysql {

    # Load the variables used in this module. Check the params.pp file 
    require mysql::params

    # Set root password
    if "${mysql::params::root_password}" != "" { include mysql::password }

    # Basic Package - Service - Configuration file management
    package { "mysql":
        name   => "${mysql::params::packagename}",
        ensure => present,
    }

    service { "mysql":
        name       => "${mysql::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${mysql::params::hasstatus}",
        pattern    => "${mysql::params::processname}",
        require    => Package["mysql"],
        subscribe  => File["mysql.conf"],
    }

    file { "mysql.conf":
        path    => "${mysql::params::configfile}",
        mode    => "${mysql::params::configfile_mode}",
        owner   => "${mysql::params::configfile_owner}",
        group   => "${mysql::params::configfile_group}",
        ensure  => present,
        require => Package["mysql"],
        notify  => Service["mysql"],
#        content => template("mysql/mysql.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes
    if $puppi == "yes" { include mysql::puppi }
    if $backup == "yes" { include mysql::backup }
    if $monitor == "yes" { include mysql::monitor }
    if $firewall == "yes" { include mysql::firewall }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "mysql::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include mysql::debug }

}
