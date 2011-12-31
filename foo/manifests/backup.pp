# Class: foo::backup
#
# Backups foo data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $foo_backup_data (true|false) : Set if you want to backup foo's data. Default: As defined in $backup_data
# $foo_backup_log (true|false) : Set if you want to backup foo's logs. Default: As defined in $backup_log
# $foo_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your foo backups. Default: daily.
# $foo_backup_target : Define how to reach (Ip, fqdn...) this host to backup foo from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check foo::params
#
# Usage:
# Automatically included if $backup=yes
#
class foo::backup {

    include foo::params

    backup { "foo_data": 
        frequency => "${foo::params::backup_frequency}",
        path      => "${foo::params::datadir}",
        enabled   => "${foo::params::backup_data_enable}",
        target    => "${foo::params::backup_target_real}",
    }
    
    backup { "foo_logs": 
        frequency => "${foo::params::backup_frequency}",
        path      => "${foo::params::logdir}",
        enabled   => "${foo::params::backup_log_enable}",
        target    => "${foo::params::backup_target_real}",
    }

}
