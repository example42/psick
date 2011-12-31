#
# Class: vsftpd
#
# Manages vsftpd.
# Include it to install and run vsftpd
# It defines package, service, main configuration file.
#
# Usage:
# include vsftpd
#
class vsftpd {

    # Load the variables used in this module. Check the params.pp file 
    require vsftpd::params

    # Basic Package - Service - Configuration file management
    package { "vsftpd":
        name   => "${vsftpd::params::packagename}",
        ensure => present,
    }

    service { "vsftpd":
        name       => "${vsftpd::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${vsftpd::params::hasstatus}",
        pattern    => "${vsftpd::params::processname}",
        require    => Package["vsftpd"],
        subscribe  => File["vsftpd.conf"],
    }

    file { "vsftpd.conf":
        path    => "${vsftpd::params::configfile}",
        mode    => "${vsftpd::params::configfile_mode}",
        owner   => "${vsftpd::params::configfile_owner}",
        group   => "${vsftpd::params::configfile_group}",
        ensure  => present,
        require => Package["vsftpd"],
        notify  => Service["vsftpd"],
        content => template("vsftpd/vsftpd.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include extended classes, if 
    if $backup == "yes" { include vsftpd::backup }
    if $monitor == "yes" { include vsftpd::monitor }
    if $firewall == "yes" { include vsftpd::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "vsftpd::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vsftpd::debug }

}
