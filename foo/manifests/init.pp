#
# Class: foo
#
# Manages foo.
# Include it to install and run foo
# It defines package, service, main configuration file.
#
# Usage:
# include foo
#
class foo {

    # Load the variables used in this module. Check the params.pp file 
    require foo::params

    # Basic Package - Service - Configuration file management
    package { "foo":
        name   => "${foo::params::packagename}",
        ensure => present,
    }

    service { "foo":
        name       => "${foo::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${foo::params::hasstatus}",
        pattern    => "${foo::params::processname}",
        require    => Package["foo"],
        subscribe  => File["foo.conf"],
    }

    file { "foo.conf":
        path    => "${foo::params::configfile}",
        mode    => "${foo::params::configfile_mode}",
        owner   => "${foo::params::configfile_owner}",
        group   => "${foo::params::configfile_group}",
        ensure  => present,
        require => Package["foo"],
        notify  => Service["foo"],
        # content => template("foo/foo.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "foo::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include foo::puppi }
    if $backup == "yes" { include foo::backup }
    if $monitor == "yes" { include foo::monitor }
    if $firewall == "yes" { include foo::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include foo::debug }

}
