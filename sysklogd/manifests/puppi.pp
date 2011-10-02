# Class: sysklogd::puppi
#
# This class manages the puppi extensions for the sysklogd module
# It's automatically included and used if $puppi=yes
#
class sysklogd::puppi {
    
    puppi::info::module { "sysklogd":
        packagename => "${sysklogd::params::packagename}",
        servicename => "${sysklogd::params::servicename}",
        processname => "${sysklogd::params::processname}",
        configfile  => "${sysklogd::params::configfile}",
        configdir   => "${sysklogd::params::configdir}",
        pidfile     => "${sysklogd::params::pidfile}",
        datadir     => "${sysklogd::params::datadir}",
        logdir      => "${sysklogd::params::logdir}",
        protocol    => "${sysklogd::params::protocol}",
        port        => "${sysklogd::params::port}",
        description => "What Puppet knows about sysklogd" ,
        # run         => "sysklogd -V###",
    }

    puppi::log { "sysklogd":
        description => "Logs of sysklogd" ,  
        log      => "${sysklogd::params::logdir}",
    }

}
