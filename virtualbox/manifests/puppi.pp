# Class: virtualbox::puppi
#
# This class manages the puppi extensions for the virtualbox module
# It's automatically included and used if $puppi=yes
#
class virtualbox::puppi {
    
    puppi::info::module { "virtualbox":
        packagename => "${virtualbox::params::packagename}",
        servicename => "${virtualbox::params::servicename}",
        processname => "${virtualbox::params::processname}",
        configfile  => "${virtualbox::params::configfile}",
        configdir   => "${virtualbox::params::configdir}",
        pidfile     => "${virtualbox::params::pidfile}",
        datadir     => "${virtualbox::params::datadir}",
        logdir      => "${virtualbox::params::logdir}",
        protocol    => "${virtualbox::params::protocol}",
        port        => "${virtualbox::params::port}",
        description => "What Puppet knows about virtualbox" ,
        # run         => "virtualbox -V###",
    }

    puppi::log { "virtualbox":
        description => "Logs of virtualbox" ,  
        log      => "${virtualbox::params::logdir}",
    }

}
