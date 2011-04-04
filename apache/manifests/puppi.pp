# Class: apache::puppi
#
# This class manages the puppi extensions for the apache module
# It's automatically included and used if $puppi=yes
#
class apache::puppi {
    
    puppi::info::module { "apache":
        packagename => "${apache::params::packagename}",
        servicename => "${apache::params::servicename}",
        processname => "${apache::params::processname}",
        configfile  => "${apache::params::configfile}",
        configdir   => "${apache::params::configdir}",
        pidfile     => "${apache::params::pidfile}",
        datadir     => "${apache::params::datadir}",
        logdir      => "${apache::params::logdir}",
        protocol    => "${apache::params::protocol}",
        port        => "${apache::params::port}",
        description => "What Puppet knows about apache" ,
        run         => "httpd -V###",
    }

##    puppi::log { "apache":
##        logdir      => "${apache::params::logdir}",
##    }

}
