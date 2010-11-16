# Class: varnish::monitor::absent
#
# Remove varnish monitor elements
#
class varnish::monitor::absent {

    include varnish::params

    # Port monitoring
    monitor::port { "varnish_${varnish::params::protocol}_${varnish::params::port}": 
        protocol => "${varnish::params::protocol}",
        port     => "${varnish::params::port}",
        target   => "${varnish::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "varnish_url":
        url      => "${varnish::params::monitor_baseurl_real}/index.php",
        pattern  => "${varnish::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "varnish_process":
        process  => "${varnish::params::processname}",
        service  => "${varnish::params::servicename}",
        pidfile  => "${varnish::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "varnish_plugin":
        plugin   => "varnish",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
