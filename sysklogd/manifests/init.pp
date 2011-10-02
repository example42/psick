#
# Class: sysklogd
#
# Manages sysklogd.
# Include it to install and run sysklogd
# It defines package, service, main configuration file.
#
# Usage:
# include sysklogd
#
class sysklogd {

    # Load the variables used in this module. Check the params.pp file 
    require sysklogd::params

    # Basic Package - Service - Configuration file management
    package { "sysklogd":
        name   => "${sysklogd::params::packagename}",
        ensure => present,
    }

    service { "sysklogd":
        name       => "${sysklogd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${sysklogd::params::hasstatus}",
        pattern    => "${sysklogd::params::processname}",
        require    => Package["sysklogd"],
        subscribe  => File["sysklogd.conf"],
    }

    file { "sysklogd.conf":
        path    => "${sysklogd::params::configfile}",
        mode    => "${sysklogd::params::configfile_mode}",
        owner   => "${sysklogd::params::configfile_owner}",
        group   => "${sysklogd::params::configfile_group}",
        ensure  => present,
        require => Package["sysklogd"],
        notify  => Service["sysklogd"],
        # content => template("sysklogd/sysklogd.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "sysklogd::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include sysklogd::puppi }
    if $backup == "yes" { include sysklogd::backup }
    if $monitor == "yes" { include sysklogd::monitor }
    if $firewall == "yes" { include sysklogd::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include sysklogd::debug }

}
