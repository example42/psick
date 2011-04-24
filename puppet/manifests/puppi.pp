# Class: puppet::puppi
#
# This class manages the puppi extensions for the puppet module
# It's automatically included and used if $puppi=yes
#
class puppet::puppi {
    
    puppi::info::module { "puppet":
        packagename => "${puppet::params::packagename}",
        servicename => "${puppet::params::servicename}",
        processname => "${puppet::params::processname}",
        configfile  => "${puppet::params::configfile}",
        configdir   => "${puppet::params::configdir}",
        pidfile     => "${puppet::params::pidfile}",
        datadir     => "${puppet::params::datadir}",
        logdir      => "${puppet::params::logdir}",
        protocol    => "${puppet::params::protocol}",
        port        => "${puppet::params::port}",
        description => "What Puppet knows about puppet" ,
        run         => "puppet --genconfig | grep -v '^    #' | grep -v '^$' | grep -v '^#'",
    }

    if ($puppet_server_local == true) or ($puppet_server == "$fqdn") {
        puppi::log { "puppet":
            log      => [ "/var/log/puppet/http.log" , "/var/log/puppet/masterhttp.log" ] ,
        }
    }
}

