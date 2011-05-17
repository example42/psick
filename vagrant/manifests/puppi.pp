# Class: vagrant::puppi
#
# This class manages the puppi extensions for the vagrant module
# It's automatically included and used if $puppi=yes
#
class vagrant::puppi {
    
    puppi::info::module { "vagrant":
        packagename => "${vagrant::params::packagename}",
        servicename => "${vagrant::params::servicename}",
        processname => "${vagrant::params::processname}",
        configfile  => "${vagrant::params::configfile}",
        configdir   => "${vagrant::params::configdir}",
        pidfile     => "${vagrant::params::pidfile}",
        datadir     => "${vagrant::params::datadir}",
        logdir      => "${vagrant::params::logdir}",
        protocol    => "${vagrant::params::protocol}",
        port        => "${vagrant::params::port}",
        description => "What Puppet knows about vagrant" ,
        # run         => "vagrant -V###",
    }

    puppi::log { "vagrant":
        description => "Logs of vagrant" ,  
        log      => "${vagrant::params::logdir}",
    }

}
