# Class: sysklogd::monitor::absent
#
# Remove sysklogd monitor elements
#
class sysklogd::monitor::absent inherits sysklogd::monitor {

    include sysklogd::params

    # Port monitoring
    Monitor::Port["sysklogd_${sysklogd::params::protocol}_${sysklogd::params::port}"] { 
        enable   => "false",
    }
    
    # URL monitoring 
    Monitor::Url["sysklogd_url"] {
        enable   => "false",
    }

    # Process monitoring 
    Monitor::Process["sysklogd_process"] { 
        enable   => "false",
    }

    # Use a specific plugin (according to the monitor tool used)
    Monitor::Plugin["sysklogd_plugin"] {
        enable   => "false",
    }

}
