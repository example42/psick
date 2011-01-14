# Class: bind::backup::absent
#
# Remove bind backup elements
#
class bind::backup::absent {

    include bind::params

    backup { "bind_data": 
        frequency => "${bind::params::backup_frequency}",
        path      => "${bind::params::datadir}",
        enabled   => "false",
        target    => "${bind::params::backup_target_real}",
    }
    
    backup { "bind_logs": 
        frequency => "${bind::params::backup_frequency}",
        path      => "${bind::params::logdir}",
        enabled   => "false",
        target    => "${bind::params::backup_target_real}",
    }

}
