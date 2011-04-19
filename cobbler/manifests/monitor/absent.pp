# Class: cobbler::monitor::absent
#
# Remove cobbler monitor elements
#
class cobbler::monitor::absent {

    include cobbler::params

    # Port monitoring
    monitor::port { "cobbler_${cobbler::params::protocol}_${cobbler::params::port}": 
        protocol => "${cobbler::params::protocol}",
        port     => "${cobbler::params::port}",
        target   => "${cobbler::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "cobbler_url":
        url      => "${cobbler::params::monitor_baseurl_real}/index.php",
        pattern  => "${cobbler::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "cobbler_process":
        process  => "${cobbler::params::processname}",
        service  => "${cobbler::params::servicename}",
        pidfile  => "${cobbler::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "cobbler_plugin":
        plugin   => "cobbler",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
