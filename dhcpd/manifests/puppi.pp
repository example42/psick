# Class: dhcpd::puppi
#
# This class manages the puppi extensions for the dhcpd module
# It's automatically included and used if $puppi=yes
#
class dhcpd::puppi {
    
    puppi::info::module { "dhcpd":
        packagename => "${dhcpd::params::packagename}",
        servicename => "${dhcpd::params::servicename}",
        processname => "${dhcpd::params::processname}",
        configfile  => "${dhcpd::params::configfile}",
        configdir   => "${dhcpd::params::configdir}",
        pidfile     => "${dhcpd::params::pidfile}",
        datadir     => "${dhcpd::params::datadir}",
        logdir      => "${dhcpd::params::logdir}",
        protocol    => "${dhcpd::params::protocol}",
        port        => "${dhcpd::params::port}",
        description => "What Puppet knows about dhcpd" ,
        # run         => "dhcpd -V###",
    }

    puppi::log { "dhcpd":
        description => "Logs of dhcpd" ,  
        log      => "${dhcpd::params::logdir}",
    }

}
