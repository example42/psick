#
# Class: postgresql
#
# Manages postgresql.
# Include it to install and run postgresql
# It defines package, service, main configuration file.
#
# Usage:
# include postgresql
#
class postgresql {

    # Load the variables used in this module. Check the params.pp file 
    require postgresql::params

    # Basic Package - Service - Configuration file management
    package { "postgresql":
        name   => "${postgresql::params::packagename}",
        ensure => present,
    }

    service { "postgresql":
        name       => "${postgresql::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${postgresql::params::hasstatus}",
        pattern    => "${postgresql::params::processname}",
        require    => Package["postgresql"],
        subscribe  => File["postgresql.conf"],
    }

    file { "postgresql.conf":
        path    => "${postgresql::params::configfile}",
        mode    => "${postgresql::params::configfile_mode}",
        owner   => "${postgresql::params::configfile_owner}",
        group   => "${postgresql::params::configfile_group}",
        ensure  => present,
        require => Package["postgresql"],
        before  => Service["postgresql"],
        notify  => Service["postgresql"],
        # content => template("postgresql/postgresql.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        centos: { include postgresql::redhat }
        redhat: { include postgresql::redhat }
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "postgresql::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include postgresql::puppi }
    if $monitor == "yes" { include postgresql::monitor }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include postgresql::debug }

}
