# Class: dovecot::backup::absent
#
# Remove dovecot backup elements
#
class dovecot::backup::absent {

    include dovecot::params

    backup { "dovecot_data": 
        frequency => "${dovecot::params::backup_frequency}",
        path      => "${dovecot::params::datadir}",
        enabled   => "false",
        target    => "${dovecot::params::backup_target_real}",
    }
    
    backup { "dovecot_logs": 
        frequency => "${dovecot::params::backup_frequency}",
        path      => "${dovecot::params::logdir}",
        enabled   => "false",
        target    => "${dovecot::params::backup_target_real}",
    }

}
