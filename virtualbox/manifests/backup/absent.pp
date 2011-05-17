# Class: virtualbox::backup::absent
#
# Remove virtualbox backup elements
#
class virtualbox::backup::absent {

    include virtualbox::params

    backup { "virtualbox_data": 
        frequency => "${virtualbox::params::backup_frequency}",
        path      => "${virtualbox::params::datadir}",
        enabled   => "false",
        target    => "${virtualbox::params::backup_target_real}",
    }
    
    backup { "virtualbox_logs": 
        frequency => "${virtualbox::params::backup_frequency}",
        path      => "${virtualbox::params::logdir}",
        enabled   => "false",
        target    => "${virtualbox::params::backup_target_real}",
    }

}
