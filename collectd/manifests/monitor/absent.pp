# Class: collectd::monitor::absent
#
# Remove collectd monitor elements
#
class collectd::monitor::absent {

    include collectd::params

    # Port monitoring
    monitor::port { "collectd_${collectd::params::protocol}_${collectd::params::port}": 
        protocol => "${collectd::params::protocol}",
        port     => "${collectd::params::port}",
        target   => "${collectd::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "collectd_url":
        url      => "${collectd::params::monitor_baseurl_real}/index.php",
        pattern  => "${collectd::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "collectd_process":
        process  => "${collectd::params::processname}",
        service  => "${collectd::params::servicename}",
        pidfile  => "${collectd::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "collectd_plugin":
        plugin   => "collectd",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
