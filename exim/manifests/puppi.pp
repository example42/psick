# Class: exim::puppi
#
# This class manages the puppi extensions for the exim module
# It's automatically included and used if $puppi=yes
#
class exim::puppi {
    
    puppi::info::module { "exim":
        packagename => "${exim::params::packagename}",
        servicename => "${exim::params::servicename}",
        processname => "${exim::params::processname}",
        configfile  => "${exim::params::configfile}",
        configdir   => "${exim::params::configdir}",
        pidfile     => "${exim::params::pidfile}",
        datadir     => "${exim::params::datadir}",
        logdir      => "${exim::params::logdir}",
        protocol    => "${exim::params::protocol}",
        port        => "${exim::params::port}",
        description => "What Puppet knows about exim" ,
        # run         => "exim -V###",
    }

    puppi::log { "exim":
        description => "Logs of exim" ,  
        log      => "${exim::params::logdir}",
    }

}
