# Class: openvpn::puppi
#
# This class manages the puppi extensions for the openvpn module
# It's automatically included and used if $puppi=yes
#
class openvpn::puppi {
    
    puppi::info::module { "openvpn":
        packagename => "${openvpn::params::packagename}",
        servicename => "${openvpn::params::servicename}",
        processname => "${openvpn::params::processname}",
        configfile  => "${openvpn::params::configfile}",
        configdir   => "${openvpn::params::configdir}",
        pidfile     => "${openvpn::params::pidfile}",
        datadir     => "${openvpn::params::datadir}",
        logdir      => "${openvpn::params::logdir}",
        protocol    => "${openvpn::params::protocol}",
        port        => "${openvpn::params::port}",
        description => "What Puppet knows about openvpn" ,
        # run         => "openvpn -V###",
    }

##    puppi::log { "openvpn":
##        log      => "${openvpn::params::logdir}",
##    }

}
