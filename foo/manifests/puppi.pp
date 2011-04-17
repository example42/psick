# Class: foo::puppi
#
# This class manages the puppi extensions for the foo module
# It's automatically included and used if $puppi=yes
#
class foo::puppi {
    
    puppi::info::module { "foo":
        packagename => "${foo::params::packagename}",
        servicename => "${foo::params::servicename}",
        processname => "${foo::params::processname}",
        configfile  => "${foo::params::configfile}",
        configdir   => "${foo::params::configdir}",
        pidfile     => "${foo::params::pidfile}",
        datadir     => "${foo::params::datadir}",
        logdir      => "${foo::params::logdir}",
        protocol    => "${foo::params::protocol}",
        port        => "${foo::params::port}",
        description => "What Puppet knows about foo" ,
        # run         => "foo -V###",
    }

    puppi::log { "foo":
        description => "Logs of foo" ,  
        log      => "${foo::params::logdir}",
    }

}
