# Class: samba::puppi
#
# This class manages the puppi extensions for the samba module
# It's automatically included and used if $puppi=yes
#
class samba::puppi {
    
    puppi::info::module { "samba":
        packagename => "${samba::params::packagename}",
        servicename => "${samba::params::servicename}",
        processname => "${samba::params::processname}",
        configfile  => "${samba::params::configfile}",
        configdir   => "${samba::params::configdir}",
        pidfile     => "${samba::params::pidfile}",
        datadir     => "${samba::params::datadir}",
        logdir      => "${samba::params::logdir}",
        protocol    => "${samba::params::protocol}",
        port        => "${samba::params::port}",
        description => "What Puppet knows about samba" ,
        # run         => "samba -V###",
    }

    puppi::log { "samba":
        description => "Logs of samba" ,  
        log      => "${samba::params::logdir}",
    }

}
