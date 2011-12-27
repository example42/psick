# Class: cobbler::backup
#
# Backups cobbler data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $cobbler_backup_data (true|false) : Set if you want to backup cobbler's data. Default: As defined in $backup_data
# $cobbler_backup_log (true|false) : Set if you want to backup cobbler's logs. Default: As defined in $backup_log
# $cobbler_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your cobbler backups. Default: daily.
# $cobbler_backup_target : Define how to reach (Ip, fqdn...) this host to backup cobbler from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check cobbler::params
#
# Usage:
# Automatically included if $backup=yes
#
class cobbler::backup {

    include cobbler::params

    backup { "cobbler_data": 
        frequency => "${cobbler::params::backup_frequency}",
        path      => "${cobbler::params::datadir}",
        enabled   => "${cobbler::params::backup_data_enable}",
        target    => "${cobbler::params::backup_target_real}",
    }
    
    backup { "cobbler_logs": 
        frequency => "${cobbler::params::backup_frequency}",
        path      => "${cobbler::params::logdir}",
        enabled   => "${cobbler::params::backup_log_enable}",
        target    => "${cobbler::params::backup_target_real}",
    }

}
