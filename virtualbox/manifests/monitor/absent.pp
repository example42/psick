# Class: virtualbox::monitor::absent
#
# Remove virtualbox monitor elements
#
class virtualbox::monitor::absent {

    include virtualbox::params

    # Port monitoring
    monitor::port { "virtualbox_${virtualbox::params::protocol}_${virtualbox::params::port}": 
        protocol => "${virtualbox::params::protocol}",
        port     => "${virtualbox::params::port}",
        target   => "${virtualbox::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "virtualbox_url":
        url      => "${virtualbox::params::monitor_baseurl_real}/index.php",
        pattern  => "${virtualbox::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "virtualbox_process":
        process  => "${virtualbox::params::processname}",
        service  => "${virtualbox::params::servicename}",
        pidfile  => "${virtualbox::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "virtualbox_plugin":
        plugin   => "virtualbox",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
