# Class: mysql::puppi
#
# This class manages the puppi extensions for the mysql module
# It's automatically included and used if $puppi=yes
#
class mysql::puppi {
    
    puppi::info::module { "mysql":
        packagename => "${mysql::params::packagename}",
        servicename => "${mysql::params::servicename}",
        processname => "${mysql::params::processname}",
        configfile  => "${mysql::params::configfile}",
        configdir   => "${mysql::params::configdir}",
        pidfile     => "${mysql::params::pidfile}",
        datadir     => "${mysql::params::cache_dir}",
        logfile     => "${mysql::params::logfile}",
        logdir      => "${mysql::params::logdir}",
        protocol    => "${mysql::params::protocol}",
        port        => "${mysql::params::port}",
        description => "What Puppet knows about mysql" ,
        # run         => "mysqlcheck --all-databases",
    }

    puppi::log { "mysql":
        log      => "${mysql::params::logfile}" ,
    }

}
