# Class: portmap::monitor::absent
#
# Remove portmap monitor elements
#
class portmap::monitor::absent {

    include portmap::params

    # Port monitoring
    monitor::port { "portmap_${portmap::params::protocol}_${portmap::params::port}": 
        protocol => "${portmap::params::protocol}",
        port     => "${portmap::params::port}",
        target   => "${portmap::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "portmap_url":
        url      => "${portmap::params::monitor_baseurl_real}/index.php",
        pattern  => "${portmap::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "portmap_process":
        process  => "${portmap::params::processname}",
        service  => "${portmap::params::servicename}",
        pidfile  => "${portmap::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "portmap_plugin":
        plugin   => "portmap",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
