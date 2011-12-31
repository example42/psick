# Class: vmware::backup
#
# Backups vmware data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $vmware_backup_data (true|false) : Set if you want to backup vmware's data. Default: As defined in $backup_data
# $vmware_backup_log (true|false) : Set if you want to backup vmware's logs. Default: As defined in $backup_log
# $vmware_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your vmware backups. Default: daily.
# $vmware_backup_target : Define how to reach (Ip, fqdn...) this host to backup vmware from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check vmware::params
#
# Usage:
# Automatically included if $backup=yes
#
class vmware::backup {

    include vmware::params

    backup { "vmware_data": 
        frequency => "${vmware::params::backup_frequency}",
        path      => "${vmware::params::datadir}",
        enabled   => "${vmware::params::backup_data_enable}",
        target    => "${vmware::params::backup_target_real}",
    }
    
    backup { "vmware_logs": 
        frequency => "${vmware::params::backup_frequency}",
        path      => "${vmware::params::logdir}",
        enabled   => "${vmware::params::backup_log_enable}",
        target    => "${vmware::params::backup_target_real}",
    }

}
