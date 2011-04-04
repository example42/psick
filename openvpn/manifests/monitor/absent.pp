# Class: openvpn::monitor::absent
#
# Remove openvpn monitor elements
#
class openvpn::monitor::absent {

    include openvpn::params

    # Port monitoring
    monitor::port { "openvpn_${openvpn::params::protocol}_${openvpn::params::port}": 
        protocol => "${openvpn::params::protocol}",
        port     => "${openvpn::params::port}",
        target   => "${openvpn::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "openvpn_url":
        url      => "${openvpn::params::monitor_baseurl_real}/index.php",
        pattern  => "${openvpn::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "openvpn_process":
        process  => "${openvpn::params::processname}",
        service  => "${openvpn::params::servicename}",
        pidfile  => "${openvpn::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "openvpn_plugin":
        plugin   => "openvpn",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
