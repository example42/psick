# Class: dashboard::puppi
#
# This class manages the puppi extensions for the dashboard module
# It's automatically included and used if $puppi=yes
#
class dashboard::puppi {
    
    puppi::info::module { "dashboard":
        packagename => "${dashboard::params::packagename}",
        servicename => "${dashboard::params::servicename}",
        processname => "${dashboard::params::processname}",
        configfile  => "${dashboard::params::configfile}###${dashboard::params::configfilesettings}",
        configdir   => "${dashboard::params::configdir}",
        pidfile     => "${dashboard::params::pidfile}",
        datadir     => "${dashboard::params::cache_dir}",
        logfile     => "/usr/share/puppet-dashboard/log/production.log",
        logdir      => "${dashboard::params::logdir}",
        protocol    => "${dashboard::params::protocol}",
        port        => "${dashboard::params::port}",
        description => "What Puppet knows about dashboard" ,
#        run         => "${dashboard::params::processname} -V###",
    }

    puppi::log { "dashboard":
        log      => "/usr/share/puppet-dashboard/log/production.log",
    }

}

