# Class: nfs::puppi
#
# This class manages the puppi extensions for the nfs module
# It's automatically included and used if $puppi=yes
#
class nfs::puppi {
    
    puppi::info::module { "nfs":
        packagename => "${nfs::params::packagename}",
        servicename => "${nfs::params::servicename}",
        processname => "${nfs::params::processname}",
        configfile  => "${nfs::params::configfile}",
        configdir   => "${nfs::params::configdir}",
        pidfile     => "${nfs::params::pidfile}",
        datadir     => "${nfs::params::datadir}",
        logdir      => "${nfs::params::logdir}",
        protocol    => "${nfs::params::protocol}",
        port        => "${nfs::params::port}",
        description => "What Puppet knows about nfs" ,
        # run         => "nfs -V###",
    }

#    puppi::log { "nfs":
#        description => "Logs of nfs" ,  
#        log      => "${nfs::params::logdir}",
#    }

}
