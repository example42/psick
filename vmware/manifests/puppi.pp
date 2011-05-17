# Class: vmware::puppi
#
# This class manages the puppi extensions for the vmware module
# It's automatically included and used if $puppi=yes
#
class vmware::puppi {
    
    puppi::info::module { "vmware":
        packagename => "${vmware::params::packagename}",
        servicename => "${vmware::params::servicename}",
        processname => [ "${vmware::params::processname}" , "${vmware::params::processname_web}" ],
        configfile  => "${vmware::params::configfile}",
        configdir   => "${vmware::params::configdir}",
        pidfile     => "${vmware::params::pidfile}",
        datadir     => "${vmware::params::datadir}",
        logdir      => "${vmware::params::logdir}",
        protocol    => "${vmware::params::protocol}",
        port        => [ "${vmware::params::port}" , "${vmware::params::port_web}" ],
        description => "What Puppet knows about vmware" ,
        # run         => "vmware -V###",
    }

    puppi::log { "vmware":
        description => "Logs of vmware" ,  
        log      => [ "${vmware::params::logdir}/*", "${vmware::params::logdir}/webAccess/*" ] ,
    }

}
