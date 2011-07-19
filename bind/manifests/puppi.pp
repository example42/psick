# Class: bind::puppi
#
# This class manages the puppi extensions for the bind module
# It's automatically included and used if $puppi=yes
#
class bind::puppi {
    
    puppi::info::module { "bind":
        packagename => "${bind::params::packagename}",
        servicename => "${bind::params::servicename}",
        processname => "${bind::params::processname}",
        configfile  => "${bind::params::configfile}",
        configdir   => "${bind::params::configdir}",
        pidfile     => "${bind::params::pidfile}",
        datadir     => "${bind::params::datadir}",
        logdir      => "${bind::params::logdir}/bind.log" ,
        protocol    => "${bind::params::protocol}",
        port        => "${bind::params::port}",
        description => "What Puppet knows about bind" ,
        run         => "rndc status",
    }

    puppi::log { "bind":
        log      => "${bind::params::logdir}/bind.log" ,
    }

}

