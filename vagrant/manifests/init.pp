#
# Class: vagrant
#
# Manages vagrant.
# Include it to install and run vagrant
# It defines package, service, main configuration file.
#
# Usage:
# include vagrant
#
class vagrant {

    # Load the variables used in this module. Check the params.pp file 
    require vagrant::params

    # Basic Package - Service - Configuration file management
    package { "vagrant":
        name   => "${vagrant::params::packagename}",
        ensure => present,
        provider => gem,
    }

#    service { "vagrant":
#        name       => "${vagrant::params::servicename}",
#        ensure     => running,
#        enable     => true,
#        hasrestart => true,
#        hasstatus  => "${vagrant::params::hasstatus}",
#        pattern    => "${vagrant::params::processname}",
#        require    => Package["vagrant"],
#        subscribe  => File["vagrant.conf"],
#    }

    file { "vagrant.conf":
        path    => "${vagrant::params::configfile}",
        mode    => "${vagrant::params::configfile_mode}",
        owner   => "${vagrant::params::configfile_owner}",
        group   => "${vagrant::params::configfile_group}",
        ensure  => present,
        require => Package["vagrant"],
#        notify  => Service["vagrant"],
        # content => template("vagrant/vagrant.conf.erb"),
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "vagrant::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include vagrant::puppi }
    if $backup == "yes" { include vagrant::backup }
    if $monitor == "yes" { include vagrant::monitor }
    if $firewall == "yes" { include vagrant::firewall }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vagrant::debug }

}
