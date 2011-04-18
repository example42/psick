# Class: postfix::monitor::absent
#
# Remove postfix monitor elements
#
class postfix::monitor::absent {

    include postfix::params

    # Port monitoring
    monitor::port { "postfix_${postfix::params::protocol}_${postfix::params::port}": 
        protocol => "${postfix::params::protocol}",
        port     => "${postfix::params::port}",
        target   => "${postfix::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "postfix_url":
        url      => "${postfix::params::monitor_baseurl_real}/index.php",
        pattern  => "${postfix::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "postfix_process":
        process  => "${postfix::params::processname}",
        service  => "${postfix::params::servicename}",
        pidfile  => "${postfix::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "postfix_plugin":
        plugin   => "postfix",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
