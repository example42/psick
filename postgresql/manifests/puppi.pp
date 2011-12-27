# Class: postgresql::puppi
#
# This class manages the puppi extensions for the postgresql module
# It's automatically included and used if $puppi=yes
#
class postgresql::puppi {

    include postgresql::params
    
    puppi::info::module { "postgresql":
        packagename => "${postgresql::params::packagename}",
        servicename => "${postgresql::params::servicename}",
        processname => "${postgresql::params::processname}",
#        processuser => "${postgresql::params::processuser}",
        configfile  => "${postgresql::params::configfile}",
        configdir   => "${postgresql::params::configdir}",
        pidfile     => "${postgresql::params::pidfile}",
        datadir     => "${postgresql::params::datadir}",
        logdir      => "${postgresql::params::logdir}",
        logfile     => $postgresql::params::logfile,
        protocol    => "${postgresql::params::protocol}",
        port        => "${postgresql::params::port}",
        description => "What Puppet knows about postgresql" ,
        # run         => "postgresql -V",
    }

    puppi::log { "postgresql":
        description => "Logs of postgresql" ,  
        log      => $postgresql::params::logfile,
    }

}
