# Class: nrpe::puppi
#
# This class manages the puppi extensions for the nrpe module
# It's automatically included and used if $puppi=yes
#
class nrpe::puppi {
    
    puppi::info::module { "nrpe":
        packagename => "${nrpe::params::packagename}",
        servicename => "${nrpe::params::servicename}",
        processname => "${nrpe::params::processname}",
        configfile  => "${nrpe::params::configfile}",
        configdir   => "${nrpe::params::configdir}",
        pidfile     => "${nrpe::params::pidfile}",
        datadir     => "${nrpe::params::datadir}",
        logdir      => "${nrpe::params::logdir}",
        protocol    => "${nrpe::params::protocol}",
        port        => "${nrpe::params::port}",
        description => "What Puppet knows about nrpe" ,
        # run         => "",
    }

##    puppi::log { "nrpe":
##        logdir      => "${nrpe::params::logdir}",
##    }

}
