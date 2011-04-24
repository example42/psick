# Class: activemq::puppi
#
# This class manages the puppi extensions for the activemq module
# It's automatically included and used if $puppi=yes
#
class activemq::puppi {
    
    puppi::info::module { "activemq":
        packagename => "${activemq::params::packagename}",
        servicename => "${activemq::params::servicename}",
        processname => "${activemq::params::processname}",
        configfile  => "${activemq::params::configfile}",
        configdir   => "${activemq::params::configdir}",
        pidfile     => "${activemq::params::pidfile}",
        datadir     => "${activemq::params::datadir}",
        logdir      => "${activemq::params::logdir}",
        protocol    => "${activemq::params::protocol}",
        port        => "${activemq::params::port}",
        description => "What Puppet knows about activemq" ,
        run         => "ls -lR ${activemq::params::logdir}/activemq-data/",
    }

    puppi::log { "activemq":
        log      => [ "${activemq::params::logdir}/activemq.log" , "${activemq::params::logdir}/wrapper.log" , "${activemq::params::logdir}/status.log" ] ,
    }

}

