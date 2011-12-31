# Class: nfs::backup
#
# Backups nfs data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $nfs_backup_data (true|false) : Set if you want to backup nfs's data. Default: As defined in $backup_data
# $nfs_backup_log (true|false) : Set if you want to backup nfs's logs. Default: As defined in $backup_log
# $nfs_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your nfs backups. Default: daily.
# $nfs_backup_target : Define how to reach (Ip, fqdn...) this host to backup nfs from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check nfs::params
#
# Usage:
# Automatically included if $backup=yes
#
class nfs::backup {

    include nfs::params

    backup { "nfs_data": 
        frequency => "${nfs::params::backup_frequency}",
        path      => "${nfs::params::datadir}",
        enabled   => "${nfs::params::backup_data_enable}",
        target    => "${nfs::params::backup_target_real}",
    }
    
    backup { "nfs_logs": 
        frequency => "${nfs::params::backup_frequency}",
        path      => "${nfs::params::logdir}",
        enabled   => "${nfs::params::backup_log_enable}",
        target    => "${nfs::params::backup_target_real}",
    }

}
