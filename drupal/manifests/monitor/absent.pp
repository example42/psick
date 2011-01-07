# Class: drupal::monitor::absent
#
# Remove drupal monitor elements
#
class drupal::monitor::absent {

    include drupal::params

    # Port monitoring
    monitor::port { "drupal_${drupal::params::protocol}_${drupal::params::port}": 
        protocol => "${drupal::params::protocol}",
        port     => "${drupal::params::port}",
        target   => "${drupal::params::monitor_target_real}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }
    
    # URL monitoring 
    monitor::url { "drupal_url":
        url      => "${drupal::params::monitor_baseurl_real}/index.php",
        pattern  => "${drupal::params::monitor_url_pattern}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Process monitoring 
    monitor::process { "drupal_process":
        process  => "${drupal::params::processname}",
        service  => "${drupal::params::servicename}",
        pidfile  => "${drupal::params::pidfile}",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

    # Use a specific plugin (according to the monitor tool used)
    monitor::plugin { "drupal_plugin":
        plugin   => "drupal",
        enable   => "false",
        tool     => "${monitor_tool}",
    }

}
