class syslog::disable inherits syslog::base {
    Service["syslog"] {
        ensure => "stopped" ,
        enable => "false",
    }
}

