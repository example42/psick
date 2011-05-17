# Class: vagrant::monitor::absent
#
# Remove vagrant monitor elements
#
class vagrant::monitor::absent {

    include vagrant::params

    # Port monitoring
    monitor::port { "vagrant_${vagrant::params::protocol}_${vagrant::params::port}": 
        protocol => "${vagrant::params::protocol}",
        port     => "${vagrant::params::port}",
        target   => "${vagrant::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "vagrant_url":
        url      => "${vagrant::params::monitor_baseurl_real}/index.php",
        pattern  => "${vagrant::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "vagrant_process":
        process  => "${vagrant::params::processname}",
        service  => "${vagrant::params::servicename}",
        pidfile  => "${vagrant::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "vagrant_plugin":
        plugin   => "vagrant",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
