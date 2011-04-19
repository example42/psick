# Class: cobbler::puppi
#
# This class manages the puppi extensions for the cobbler module
# It's automatically included and used if $puppi=yes
#
class cobbler::puppi {
    
    puppi::info::module { "cobbler":
        packagename => "${cobbler::params::packagename}",
        servicename => "${cobbler::params::servicename}",
        processname => "${cobbler::params::processname}",
        configfile  => "${cobbler::params::configfile}",
        configdir   => "${cobbler::params::configdir}",
        pidfile     => "${cobbler::params::pidfile}",
        datadir     => "${cobbler::params::datadir}",
        logdir      => "${cobbler::params::logdir}",
        protocol    => "${cobbler::params::protocol}",
        port        => "${cobbler::params::port}",
        description => "What Puppet knows about cobbler" ,
        # run         => "cobbler -V###",
    }

    puppi::log { "cobbler":
        description => "Logs of cobbler" ,  
        log      => "${cobbler::params::logdir}",
    }

}
