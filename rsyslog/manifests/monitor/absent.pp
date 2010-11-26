# Class: rsyslog::monitor::absent
#
# Remove rsyslog monitor elements
#
class rsyslog::monitor::absent {

    include rsyslog::params

    # Port monitoring
    monitor::port { "rsyslog_${rsyslog::params::protocol}_${rsyslog::params::port}": 
        protocol => "${rsyslog::params::protocol}",
        port     => "${rsyslog::params::port}",
        target   => "${rsyslog::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "rsyslog_url":
        url      => "${rsyslog::params::monitor_baseurl_real}/index.php",
        pattern  => "${rsyslog::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "rsyslog_process":
        process  => "${rsyslog::params::processname}",
        service  => "${rsyslog::params::servicename}",
        pidfile  => "${rsyslog::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "rsyslog_plugin":
        plugin   => "rsyslog",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
