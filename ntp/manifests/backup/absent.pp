# Class: ntp::backup::absent
#
# Remove ntp backup elements
#
class ntp::backup::absent {

    include ntp::params

    backup { "ntp_data": 
        frequency => "${ntp::params::backup_frequency}",
        path      => "${ntp::params::datadir}",
        enabled   => "false",
        target    => "${ntp::params::backup_target_real}",
    }
    
    backup { "ntp_logs": 
        frequency => "${ntp::params::backup_frequency}",
        path      => "${ntp::params::logdir}",
        enabled   => "false",
        target    => "${ntp::params::backup_target_real}",
    }

}
