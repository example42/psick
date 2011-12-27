# Class: bind::backup
#
# Backups bind data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $bind_backup_data (true|false) : Set if you want to backup bind's data. Default: As defined in $backup_data
# $bind_backup_log (true|false) : Set if you want to backup bind's logs. Default: As defined in $backup_log
# $bind_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your bind backups. Default: daily.
# $bind_backup_target : Define how to reach (Ip, fqdn...) this host to backup bind from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check bind::params
#
# Usage:
# Automatically included if $backup=yes
#
class bind::backup {

    include bind::params

    backup { "bind_data": 
        frequency => "${bind::params::backup_frequency}",
        path      => "${bind::params::datadir}",
        enabled   => "${bind::params::backup_data_enable}",
        target    => "${bind::params::backup_target_real}",
    }
    
    backup { "bind_logs": 
        frequency => "${bind::params::backup_frequency}",
        path      => "${bind::params::logdir}",
        enabled   => "${bind::params::backup_log_enable}",
        target    => "${bind::params::backup_target_real}",
    }

}
