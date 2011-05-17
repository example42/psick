#
# Class: vmware
#
# Manages vmware.
# Include it to install and run vmware
# It defines package, service, main configuration file.
#
# Usage:
# include vmware
#
class vmware {

    # Load the variables used in this module. Check the params.pp file 
    require vmware::params

    # Basic Package - Service - Configuration file management
    package { "vmware":
        name   => "${vmware::params::packagename}",
        ensure => present,
    }

    service { "vmware":
        name       => "${vmware::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${vmware::params::hasstatus}",
        pattern    => "${vmware::params::processname}",
        require    => Package["vmware"],
        subscribe  => File["vmware.conf"],
    }

    file { "vmware.conf":
        path    => "${vmware::params::configfile}",
        mode    => "${vmware::params::configfile_mode}",
        owner   => "${vmware::params::configfile_owner}",
        group   => "${vmware::params::configfile_group}",
        ensure  => present,
        require => Package["vmware"],
        notify  => Service["vmware"],
        # content => template("vmware/vmware.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "vmware::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include vmware::puppi }
    if $backup == "yes" { include vmware::backup }
    if $monitor == "yes" { include vmware::monitor }
    if $firewall == "yes" { include vmware::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vmware::debug }

}
