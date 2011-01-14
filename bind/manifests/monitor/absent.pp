# Class: bind::monitor::absent
#
# Remove bind monitor elements
#
class bind::monitor::absent {

    include bind::params

    # Port monitoring
    monitor::port { "bind_${bind::params::protocol}_${bind::params::port}": 
        protocol => "${bind::params::protocol}",
        port     => "${bind::params::port}",
        target   => "${bind::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "bind_url":
        url      => "${bind::params::monitor_baseurl_real}/index.php",
        pattern  => "${bind::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "bind_process":
        process  => "${bind::params::processname}",
        service  => "${bind::params::servicename}",
        pidfile  => "${bind::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "bind_plugin":
        plugin   => "bind",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
