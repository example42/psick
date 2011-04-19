# Class: cobbler::backup::absent
#
# Remove cobbler backup elements
#
class cobbler::backup::absent {

    include cobbler::params

    backup { "cobbler_data": 
        frequency => "${cobbler::params::backup_frequency}",
        path      => "${cobbler::params::datadir}",
        enabled   => "false",
        target    => "${cobbler::params::backup_target_real}",
    }
    
    backup { "cobbler_logs": 
        frequency => "${cobbler::params::backup_frequency}",
        path      => "${cobbler::params::logdir}",
        enabled   => "false",
        target    => "${cobbler::params::backup_target_real}",
    }

}
