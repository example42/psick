# Class: foo::monitor::absent
#
# Remove foo monitor elements
#
class foo::monitor::absent {

    include foo::params

    # Port monitoring
    monitor::port { "foo_${foo::params::protocol}_${foo::params::port}": 
        protocol => "${foo::params::protocol}",
        port     => "${foo::params::port}",
        target   => "${foo::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "foo_url":
        url      => "${foo::params::monitor_baseurl_real}/index.php",
        pattern  => "${foo::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "foo_process":
        process  => "${foo::params::processname}",
        service  => "${foo::params::servicename}",
        pidfile  => "${foo::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "foo_plugin":
        plugin   => "foo",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
