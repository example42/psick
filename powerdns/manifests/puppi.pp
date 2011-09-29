# Class: powerdns::puppi
#
# This class manages the puppi extensions for the powerdns module
# It's automatically included and used if $puppi=yes
#
class powerdns::puppi {
    
    puppi::info::module { "powerdns":
        packagename => "${powerdns::params::packagename}",
        servicename => "${powerdns::params::servicename}",
        processname => "${powerdns::params::processname}",
        configfile  => "${powerdns::params::configfile}",
        configdir   => "${powerdns::params::configdir}",
        pidfile     => "${powerdns::params::pidfile}",
        datadir     => "${powerdns::params::datadir}",
        logdir      => "${powerdns::params::logdir}",
        protocol    => "${powerdns::params::protocol}",
        port        => "${powerdns::params::port}",
        description => "What Puppet knows about powerdns" ,
        # run         => "powerdns -V###",
    }

    puppi::log { "powerdns":
        description => "Logs of powerdns" ,  
        log      => "${powerdns::params::logdir}",
    }

}
