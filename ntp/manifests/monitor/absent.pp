# Class: ntp::monitor::absent
#
# Remove ntp monitor elements
#
class ntp::monitor::absent {

    include ntp::params

    # Port monitoring
    monitor::port { "ntp_${ntp::params::protocol}_${ntp::params::port}": 
        protocol => "${ntp::params::protocol}",
        port     => "${ntp::params::port}",
        target   => "${ntp::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "ntp_url":
        url      => "${ntp::params::monitor_baseurl_real}/index.php",
        pattern  => "${ntp::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "ntp_process":
        process  => "${ntp::params::processname}",
        service  => "${ntp::params::servicename}",
        pidfile  => "${ntp::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "ntp_plugin":
        plugin   => "ntp",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
