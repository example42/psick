# Class: exim::monitor::absent
#
# Remove exim monitor elements
#
class exim::monitor::absent {

    include exim::params

    # Port monitoring
    monitor::port { "exim_${exim::params::protocol}_${exim::params::port}": 
        protocol => "${exim::params::protocol}",
        port     => "${exim::params::port}",
        target   => "${exim::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "exim_url":
        url      => "${exim::params::monitor_baseurl_real}/index.php",
        pattern  => "${exim::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "exim_process":
        process  => "${exim::params::processname}",
        service  => "${exim::params::servicename}",
        pidfile  => "${exim::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "exim_plugin":
        plugin   => "exim",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
