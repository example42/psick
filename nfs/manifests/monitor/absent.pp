# Class: nfs::monitor::absent
#
# Remove nfs monitor elements
#
class nfs::monitor::absent {

    include nfs::params

    # Port monitoring
    monitor::port { "nfs_${nfs::params::protocol}_${nfs::params::port}": 
        protocol => "${nfs::params::protocol}",
        port     => "${nfs::params::port}",
        target   => "${nfs::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "nfs_url":
        url      => "${nfs::params::monitor_baseurl_real}/index.php",
        pattern  => "${nfs::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "nfs_process":
        process  => "${nfs::params::processname}",
        service  => "${nfs::params::servicename}",
        pidfile  => "${nfs::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "nfs_plugin":
        plugin   => "nfs",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
