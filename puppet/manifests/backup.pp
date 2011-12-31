# Class: puppet::backup
#
# Backups puppet data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $puppet_backup_data (true|false) : Set if you want to backup puppet's data. Default: As defined in $backup_data
# $puppet_backup_log (true|false) : Set if you want to backup puppet's logs. Default: As defined in $backup_log
# $puppet_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your puppet backups. Default: daily.
# $puppet_backup_target : Define how to reach (Ip, fqdn...) this host to backup puppet from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check puppet::params
#
# Usage:
# Automatically included if $backup=yes
#
class puppet::backup {

    include puppet::params

    backup { "puppet_data": 
        frequency => "${puppet::params::backup_frequency}",
        path      => "${puppet::params::datadir}",
        enabled   => "${puppet::params::backup_data_enable}",
        target    => "${puppet::params::backup_target_real}",
    }
    
    backup { "puppet_logs": 
        frequency => "${puppet::params::backup_frequency}",
        path      => "${puppet::params::logdir}",
        enabled   => "${puppet::params::backup_log_enable}",
        target    => "${puppet::params::backup_target_real}",
    }

}
