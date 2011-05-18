# Class: dhcpd::backup::absent
#
# Remove dhcpd backup elements
#
class dhcpd::backup::absent {

    include dhcpd::params

    backup { "dhcpd_data": 
        frequency => "${dhcpd::params::backup_frequency}",
        path      => "${dhcpd::params::datadir}",
        enabled   => "false",
        target    => "${dhcpd::params::backup_target_real}",
    }
    
    backup { "dhcpd_logs": 
        frequency => "${dhcpd::params::backup_frequency}",
        path      => "${dhcpd::params::logdir}",
        enabled   => "false",
        target    => "${dhcpd::params::backup_target_real}",
    }

}
