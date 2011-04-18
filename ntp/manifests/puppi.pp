# Class: ntp::puppi
#
# This class manages the puppi extensions for the ntp module
# It's automatically included and used if $puppi=yes
#
class ntp::puppi {
    
    puppi::info::module { "ntp":
        packagename => "${ntp::params::packagename}",
        servicename => "${ntp::params::servicename}",
        processname => "${ntp::params::processname}",
        configfile  => "${ntp::params::configfile}",
        configdir   => "${ntp::params::configdir}",
        pidfile     => "${ntp::params::pidfile}",
        datadir     => "${ntp::params::datadir}",
        logdir      => "${ntp::params::logdir}",
        protocol    => "${ntp::params::protocol}",
        port        => "${ntp::params::port}",
        description => "What Puppet knows about ntp" ,
        # run         => "ntp -V###",
    }

#    puppi::log { "ntp":
#        description => "Logs of ntp" ,  
#        log      => "${ntp::params::logdir}",
#    }

}
