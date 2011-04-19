# Class: rsync::monitor::absent
#
# Remove rsync monitor elements
#
class rsync::monitor::absent {

    include rsync::params

    # Port monitoring
    monitor::port { "rsync_${rsync::params::protocol}_${rsync::params::port}": 
        protocol => "${rsync::params::protocol}",
        port     => "${rsync::params::port}",
        target   => "${rsync::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "rsync_url":
        url      => "${rsync::params::monitor_baseurl_real}/index.php",
        pattern  => "${rsync::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "rsync_process":
        process  => "${rsync::params::processname}",
        service  => "${rsync::params::servicename}",
        pidfile  => "${rsync::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "rsync_plugin":
        plugin   => "rsync",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
