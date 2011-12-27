# Class: varnish::backup
#
# Backups varnish data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $varnish_backup_data (true|false) : Set if you want to backup varnish's data. Default: As defined in $backup_data
# $varnish_backup_log (true|false) : Set if you want to backup varnish's logs. Default: As defined in $backup_log
# $varnish_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your varnish backups. Default: daily.
# $varnish_backup_target : Define how to reach (Ip, fqdn...) this host to backup varnish from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check varnish::params
#
# Usage:
# Automatically included if $backup=yes
#
class varnish::backup {

    include varnish::params

    backup { "varnish_data": 
        frequency => "${varnish::params::backup_frequency}",
        path      => "${varnish::params::datadir}",
        enabled   => "${varnish::params::backup_data_enable}",
        target    => "${varnish::params::backup_target_real}",
    }
    
    backup { "varnish_logs": 
        frequency => "${varnish::params::backup_frequency}",
        path      => "${varnish::params::logdir}",
        enabled   => "${varnish::params::backup_log_enable}",
        target    => "${varnish::params::backup_target_real}",
    }

}
