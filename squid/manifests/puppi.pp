# Class: squid::puppi
#
# This class manages the puppi extensions for the squid module
# It's automatically included and used if $puppi=yes
#
class squid::puppi {
    
    puppi::info::module { "squid":
        packagename => "${squid::params::packagename}",
        servicename => "${squid::params::servicename}",
        processname => "${squid::params::processname}",
        configfile  => "${squid::params::configfile}",
        configdir   => "${squid::params::configdir}",
        pidfile     => "${squid::params::pidfile}",
        datadir     => "${squid::params::cache_dir}",
        logfile     => "${squid::params::logdir}/access.log",
        logdir      => "${squid::params::logdir}",
        protocol    => "${squid::params::protocol}",
        port        => "${squid::params::port}",
        description => "What Puppet knows about squid" ,
#        run         => "${squid::params::processname} -V",
    }

    puppi::log { "squid":
        log      => [ "${squid::params::logdir}/access.log" , "${squid::params::logdir}/store.log" , "${squid::params::logdir}/cache.log" ],
    }

}
