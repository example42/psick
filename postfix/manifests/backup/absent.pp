# Class: postfix::backup::absent
#
# Remove postfix backup elements
#
class postfix::backup::absent {

    include postfix::params

    backup { "postfix_data": 
        frequency => "${postfix::params::backup_frequency}",
        path      => "${postfix::params::datadir}",
        enabled   => "false",
        target    => "${postfix::params::backup_target_real}",
    }
    
    backup { "postfix_logs": 
        frequency => "${postfix::params::backup_frequency}",
        path      => "${postfix::params::logdir}",
        enabled   => "false",
        target    => "${postfix::params::backup_target_real}",
    }

}
