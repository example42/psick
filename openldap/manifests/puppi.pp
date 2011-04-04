# Class: openldap::puppi
#
# This class manages the puppi extensions for the openldap module
# It's automatically included and used if $puppi=yes
#
class openldap::puppi {
    
    puppi::info::module { "openldap":
        packagename => "${openldap::params::packagename}",
        servicename => "${openldap::params::servicename}",
        processname => "${openldap::params::processname}",
        configfile  => "${openldap::params::configfile}",
        configdir   => "${openldap::params::configdir}",
        pidfile     => "${openldap::params::pidfile}",
        datadir     => "${openldap::params::datadir}",
        logdir      => "${openldap::params::logdir}",
        protocol    => "${openldap::params::protocol}",
        port        => "${openldap::params::port}",
        description => "What Puppet knows about openldap" ,
        run         => "slapd -V###slaptest",
    }

##    puppi::log { "openldap":
##        logdir      => "${openldap::params::logdir}",
##    }

}
