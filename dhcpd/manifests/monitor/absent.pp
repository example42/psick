# Class: dhcpd::monitor::absent
#
# Remove dhcpd monitor elements
#
class dhcpd::monitor::absent {

    include dhcpd::params

    # Port monitoring
    monitor::port { "dhcpd_${dhcpd::params::protocol}_${dhcpd::params::port}": 
        protocol => "${dhcpd::params::protocol}",
        port     => "${dhcpd::params::port}",
        target   => "${dhcpd::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "dhcpd_url":
        url      => "${dhcpd::params::monitor_baseurl_real}/index.php",
        pattern  => "${dhcpd::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "dhcpd_process":
        process  => "${dhcpd::params::processname}",
        service  => "${dhcpd::params::servicename}",
        pidfile  => "${dhcpd::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "dhcpd_plugin":
        plugin   => "dhcpd",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
