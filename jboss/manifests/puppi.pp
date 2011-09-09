# Class: jboss::puppi
#
# This class manages the puppi extensions for the jboss module
# It's automatically included and used if $puppi=yes
#
class jboss::puppi {
    
    puppi::info::module { "jboss":
        servicename => "${jboss::params::servicename}",
        processname => "${jboss::params::processname}",
        configdir   => [ "${jboss::params::jboss_dir}/bin" , "${jboss::params::jboss_dir}/server/${jboss::params::instance}/conf" ],
        pidfile     => "${jboss::params::pidfile}",
        datadir     => "${jboss::params::jboss_dir}/server/${jboss::params::instance}/deploy",
        logdir      => "${jboss::params::jboss_dir}/server/${jboss::params::instance}/log",
        protocol    => "${jboss::params::protocol}",
        port        => "${jboss::params::port}",
        description => "What Puppet knows about jboss" ,
        # run         => "jboss -V###",
    }

    puppi::log { "jboss":
        description => "Logs of jboss" ,  
        log      => [ "${jboss::params::jboss_dir}/server/${jboss::params::instance}/log/server.log" , "${jboss::params::jboss_dir}/server/${jboss::params::instance}/log/boot.log" ]
    }

}
