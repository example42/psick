# Class: munin::monitor::absent
#
# Remove munin monitor elements
#
class munin::monitor::absent {

    include munin::params

    # Port monitoring
    monitor::port { "munin_${munin::params::protocol}_${munin::params::port}": 
        protocol => "${munin::params::protocol}",
        port     => "${munin::params::port}",
        target   => "${munin::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "munin_url":
        url      => "${munin::params::monitor_baseurl_real}/index.php",
        pattern  => "${munin::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "munin_process":
        process  => "${munin::params::processname}",
        service  => "${munin::params::servicename}",
        pidfile  => "${munin::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "munin_plugin":
        plugin   => "munin",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
