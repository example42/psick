# Class: munin::puppi
#
# This class manages the puppi extensions for the munin module
# It's automatically included and used if $puppi=yes
#
class munin::puppi {
    
    puppi::info::module { "munin":
        packagename => "${munin::params::packagename}",
        servicename => "${munin::params::servicename}",
        processname => "${munin::params::processname}",
        configfile  => "${munin::params::configfile}",
        configdir   => "${munin::params::configdir}",
        pidfile     => "${munin::params::pidfile}",
        datadir     => "${munin::params::cache_dir}",
        logfile     => "${munin::params::logdir}/munin-node.log",
        logdir      => "${munin::params::logdir}",
        protocol    => "${munin::params::protocol}",
        port        => "${munin::params::port}",
        description => "What Puppet knows about munin" ,
        run         => "munin-node-configure",
    }

    puppi::log { "munin":
        log      => "${munin::params::logdir}/munin-node.log" ,
    }

}
