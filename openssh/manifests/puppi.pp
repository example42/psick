# Class: openssh::puppi
#
# This class manages the puppi extensions for the openssh module
# It's automatically included and used if $puppi=yes
#
class openssh::puppi {
    
    puppi::info::module { "openssh":
        packagename => "${openssh::params::packagename}",
        servicename => "${openssh::params::servicename}",
        processname => "${openssh::params::processname}",
        configfile  => "${openssh::params::configfile}",
        configdir   => "${openssh::params::configdir}",
        pidfile     => "${openssh::params::pidfile}",
        datadir     => "${openssh::params::datadir}",
        logdir      => "${openssh::params::logdir}",
        protocol    => "${openssh::params::protocol}",
        port        => "${openssh::params::port}",
        description => "What Puppet knows about openssh" ,
        run         => "ls -la ~/.ssh/",
    }

##    puppi::log { "openssh":
##        log      => "${openssh::params::logdir}",
##    }

}
