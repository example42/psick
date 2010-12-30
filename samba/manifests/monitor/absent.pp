# Class: samba::monitor::absent
#
# Remove samba monitor elements
#
class samba::monitor::absent {

    include samba::params

    # Port monitoring
    monitor::port { "samba_${samba::params::protocol}_${samba::params::port}": 
        protocol => "${samba::params::protocol}",
        port     => "${samba::params::port}",
        target   => "${samba::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "samba_url":
        url      => "${samba::params::monitor_baseurl_real}/index.php",
        pattern  => "${samba::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "samba_process":
        process  => "${samba::params::processname}",
        service  => "${samba::params::servicename}",
        pidfile  => "${samba::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "samba_plugin":
        plugin   => "samba",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
