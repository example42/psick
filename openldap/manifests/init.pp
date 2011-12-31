#
# Class: openldap
#
# Manages openldap.
# Include it to install and run openldap
# It defines package, service, main configuration file.
#
# Usage:
# include openldap
#
class openldap {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params

    # Basic Package - Service - Configuration file management
    package { "openldap":
        name   => "${openldap::params::packagename}",
        ensure => present,
    }

    service { "openldap":
        name       => "${openldap::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${openldap::params::hasstatus}",
        pattern    => "${openldap::params::processname}",
        require    => Package["openldap"],
        subscribe  => File["openldap.conf"],
    }

    file { "openldap.conf":
        path    => "${openldap::params::configfile}",
        mode    => "${openldap::params::configfile_mode}",
        owner   => "${openldap::params::configfile_owner}",
        group   => "${openldap::params::configfile_group}",
        ensure  => present,
        require => Package["openldap"],
        notify  => Service["openldap"],
        content => template("openldap/slapd.conf.erb"),
    }

    # Support for Solaris clients
    if "${openldap::params::support_solaris_clients}" == "yes" { include openldap::solaris_clients }

    # Support for Samba (Use OpenLdap as Samba backend)
    if "${openldap::params::support_samba}" == "yes" { include openldap::samba }

    # SSL (Public certs)
    if "${openldap::params::use_ssl}" == "yes" { include openldap::ssl }

    # Include optional extra tools for users management
    if "${openldap::params::extra}" == "yes" { include openldap::extra }

    # Include ldap utils
    # include openldap::client

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        ubuntu: { include openldap::ubuntu }
        default: { }
    }

    # Include Backend specific configurations
    case "${openldap::params::db_backend}" {
        bdb: { include openldap::bdb }
        hdb: { include openldap::bdb }
        default: { }
    }

    # Include extended classes, if 
    if $puppi == "yes" { include openldap::puppi }
    if $backup == "yes" { include openldap::backup }
    if $monitor == "yes" { include openldap::monitor }
    if $firewall == "yes" { include openldap::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "openldap::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include openldap::debug }

}
