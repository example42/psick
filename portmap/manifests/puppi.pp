# Class: portmap::puppi
#
# This class manages the puppi extensions for the portmap module
# It's automatically included and used if $puppi=yes
#
class portmap::puppi {
    
    puppi::info::module { "portmap":
        packagename => "${portmap::params::packagename}",
        servicename => "${portmap::params::servicename}",
        processname => "${portmap::params::processname}",
#        configfile  => "${portmap::params::configfile}",
#        configdir   => "${portmap::params::configdir}",
        pidfile     => "${portmap::params::pidfile}",
#        datadir     => "${portmap::params::datadir}",
        logdir      => "${portmap::params::logdir}",
        protocol    => "${portmap::params::protocol}",
        port        => "${portmap::params::port}",
        description => "What Puppet knows about portmap" ,
        # run         => "portmap -V###",
    }

#    puppi::log { "portmap":
#        description => "Logs of portmap" ,  
#        log      => "${portmap::params::logdir}",
#    }

}
