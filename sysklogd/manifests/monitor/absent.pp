# Class: sysklogd::monitor::absent
#
# Remove sysklogd monitor elements
#
class sysklogd::monitor::absent {

    include sysklogd::params

    # Port monitoring
    monitor::port { "sysklogd_${sysklogd::params::protocol}_${sysklogd::params::port}": 
        protocol => "${sysklogd::params::protocol}",
        port     => "${sysklogd::params::port}",
        target   => "${sysklogd::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "sysklogd_url":
        url      => "${sysklogd::params::monitor_baseurl_real}/index.php",
        pattern  => "${sysklogd::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "sysklogd_process":
        process  => "${sysklogd::params::processname}",
        service  => "${sysklogd::params::servicename}",
        pidfile  => "${sysklogd::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "sysklogd_plugin":
        plugin   => "sysklogd",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
