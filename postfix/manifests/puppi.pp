# Class: postfix::puppi
#
# This class manages the puppi extensions for the postfix module
# It's automatically included and used if $puppi=yes
#
class postfix::puppi {
    
    puppi::info::module { "postfix":
        packagename => "${postfix::params::packagename}",
        servicename => "${postfix::params::servicename}",
        processname => "${postfix::params::processname}",
        configfile  => "${postfix::params::configfile}",
        configdir   => "${postfix::params::configdir}",
        pidfile     => "${postfix::params::pidfile}",
        datadir     => "${postfix::params::datadir}",
        logdir      => "${postfix::params::logdir}",
        protocol    => "${postfix::params::protocol}",
        port        => "${postfix::params::port}",
        description => "What Puppet knows about postfix" ,
        # run         => "postfix -V###",
    }

#    puppi::log { "postfix":
#        description => "Logs of postfix" ,  
#        log      => "${postfix::params::logdir}",
#    }

}
