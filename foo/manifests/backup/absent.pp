# Class: foo::backup::absent
#
# Remove foo backup elements
#
class foo::backup::absent {

    include foo::params

    backup { "foo_data": 
        frequency => "${foo::params::backup_frequency}",
        path      => "${foo::params::datadir}",
        enabled   => "false",
        target    => "${foo::params::backup_target_real}",
    }
    
    backup { "foo_logs": 
        frequency => "${foo::params::backup_frequency}",
        path      => "${foo::params::logdir}",
        enabled   => "false",
        target    => "${foo::params::backup_target_real}",
    }

}
