#
# Class: vagrant
#
# Manages vagrant.
# Include it to install vagrant
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
    # Note: On Centos/Rhel 6 you need installed ruby-devel and gcc

    file { "vagrant_addpath":
        path    => "/etc/profile.d/vagrant.sh", 
        mode    => 755,
        content => "#!/bin/sh\nexport PATH=\$PATH:${vagrant::params::binpath}\n",
    }

    file { "vagrant_basedir":
        path    => "${vagrant::params::basedir}",
        mode    => 755,
        ensure  => directory,
    }

    # Include OS specific subclasses, if necessary
    case $operatingsystem {
        default: { }
    }

    # Include project specific class if $my_project is set
    if $my_project { include "vagrant::${my_project}" }

    # Include extended classes, if relevant variables are defined 
    if $puppi == "yes" { include vagrant::puppi }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include vagrant::debug }

}
