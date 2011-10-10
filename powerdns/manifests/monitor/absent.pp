# Class: powerdns::monitor::absent
#
# Remove powerdns monitor elements
#
class powerdns::monitor::absent {

    include powerdns::params

    # Port monitoring
    monitor::port { "powerdns_${powerdns::params::protocol}_${powerdns::params::port}": 
        protocol => "${powerdns::params::protocol}",
        port     => "${powerdns::params::port}",
        target   => "${powerdns::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "powerdns_url":
        url      => "${powerdns::params::monitor_baseurl_real}/index.php",
        pattern  => "${powerdns::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "powerdns_process":
        process  => "${powerdns::params::processname}",
        service  => "${powerdns::params::servicename}",
        pidfile  => "${powerdns::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "powerdns_plugin":
        plugin   => "powerdns",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
