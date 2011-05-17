# Class: vmware::monitor::absent
#
# Remove vmware monitor elements
#
class vmware::monitor::absent {

    include vmware::params

    # Port monitoring
    monitor::port { "vmware_${vmware::params::protocol}_${vmware::params::port}": 
        protocol => "${vmware::params::protocol}",
        port     => "${vmware::params::port}",
        target   => "${vmware::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "vmware_url":
        url      => "${vmware::params::monitor_baseurl_real}/index.php",
        pattern  => "${vmware::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "vmware_process":
        process  => "${vmware::params::processname}",
        service  => "${vmware::params::servicename}",
        pidfile  => "${vmware::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "vmware_plugin":
        plugin   => "vmware",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
