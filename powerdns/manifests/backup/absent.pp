# Class: powerdns::backup::absent
#
# Remove powerdns backup elements
#
class powerdns::backup::absent {

    include powerdns::params

    backup { "powerdns_data": 
        frequency => "${powerdns::params::backup_frequency}",
        path      => "${powerdns::params::datadir}",
        enabled   => "false",
        target    => "${powerdns::params::backup_target_real}",
    }
    
    backup { "powerdns_logs": 
        frequency => "${powerdns::params::backup_frequency}",
        path      => "${powerdns::params::logdir}",
        enabled   => "false",
        target    => "${powerdns::params::backup_target_real}",
    }

}
