# Class: lighttpd::monitor::absent
#
# Remove lighttpd monitor elements
#
class lighttpd::monitor::absent {

    include lighttpd::params

    # Port monitoring
    monitor::port { "lighttpd_${lighttpd::params::protocol}_${lighttpd::params::port}": 
        protocol => "${lighttpd::params::protocol}",
        port     => "${lighttpd::params::port}",
        target   => "${lighttpd::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "lighttpd_url":
        url      => "${lighttpd::params::monitor_baseurl_real}/index.php",
        pattern  => "${lighttpd::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "lighttpd_process":
        process  => "${lighttpd::params::processname}",
        service  => "${lighttpd::params::servicename}",
        pidfile  => "${lighttpd::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "lighttpd_plugin":
        plugin   => "lighttpd",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
