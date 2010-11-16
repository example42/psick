# Class: varnish::backup::absent
#
# Remove varnish backup elements
#
class varnish::backup::absent {

    include varnish::params

    backup { "varnish_data": 
        frequency => "${varnish::params::backup_frequency}",
        path      => "${varnish::params::datadir}",
        enabled   => "false",
        target    => "${varnish::params::backup_target_real}",
    }
    
    backup { "varnish_logs": 
        frequency => "${varnish::params::backup_frequency}",
        path      => "${varnish::params::logdir}",
        enabled   => "false",
        target    => "${varnish::params::backup_target_real}",
    }

}
