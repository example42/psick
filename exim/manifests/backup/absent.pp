# Class: exim::backup::absent
#
# Remove exim backup elements
#
class exim::backup::absent {

    include exim::params

    backup { "exim_data": 
        frequency => "${exim::params::backup_frequency}",
        path      => "${exim::params::datadir}",
        enabled   => "false",
        target    => "${exim::params::backup_target_real}",
    }
    
    backup { "exim_logs": 
        frequency => "${exim::params::backup_frequency}",
        path      => "${exim::params::logdir}",
        enabled   => "false",
        target    => "${exim::params::backup_target_real}",
    }

}
