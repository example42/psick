# Class: mcollective::puppi
#
# This class manages the puppi extensions for the mcollective module
# It's automatically included and used if $puppi=yes
#
class mcollective::puppi {
    
    puppi::info::module { "mcollective":
        packagename => "${mcollective::params::packagename}",
        servicename => "${mcollective::params::servicename}",
        processname => "${mcollective::params::processname}",
        configfile  => "${mcollective::params::configfile}",
        configdir   => "${mcollective::params::configdir}",
        pidfile     => "${mcollective::params::pidfile}",
        datadir     => "${mcollective::params::datadir}",
        logdir      => "${mcollective::params::logdir}",
        protocol    => "${mcollective::params::protocol}",
        port        => "${mcollective::params::port}",
        description => "What Puppet knows about mcollective" ,
        run         => "ls -la /etc/mcollective/plugin.d/",
    }

    puppi::log { "mcollective":
        log      => "${mcollective::params::logdir}",
    }

}

