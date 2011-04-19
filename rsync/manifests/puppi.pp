# Class: rsync::puppi
#
# This class manages the puppi extensions for the rsync module
# It's automatically included and used if $puppi=yes
#
class rsync::puppi {
    
    puppi::info::module { "rsync":
        packagename => "${rsync::params::packagename}",
        servicename => "${rsync::params::servicename}",
        processname => "${rsync::params::processname}",
        configfile  => "${rsync::params::configfile}",
        configdir   => "${rsync::params::configdir}",
        pidfile     => "${rsync::params::pidfile}",
        datadir     => "${rsync::params::datadir}",
        logdir      => "${rsync::params::logdir}",
        protocol    => "${rsync::params::protocol}",
        port        => "${rsync::params::port}",
        description => "What Puppet knows about rsync" ,
        # run         => "rsync -V###",
    }

    puppi::log { "rsync":
        description => "Logs of rsync" ,  
        log      => "${rsync::params::logdir}",
    }

}
