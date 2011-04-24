# Class: tomcat::puppi
#
# This class manages the puppi extensions for the tomcat module
# It's automatically included and used if $puppi=yes
#
class tomcat::puppi {
    
    puppi::info::module { "tomcat":
        packagename => "${tomcat::params::packagename}",
        servicename => "${tomcat::params::servicename}",
        processname => "${tomcat::params::processname}",
        configfile  => "${tomcat::params::configfile}",
        configdir   => "${tomcat::params::configdir}",
        pidfile     => "${tomcat::params::pidfile}",
        datadir     => "${tomcat::params::datadir}",
        logdir      => "${tomcat::params::logdir}",
        protocol    => "${tomcat::params::protocol}",
        port        => "${tomcat::params::port}",
        description => "What Puppet knows about tomcat" ,
#        run         => "httpd -V",
    }

##    puppi::log { "tomcat":
##        log      => "${tomcat::params::logdir}",
##    }

}
