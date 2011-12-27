# Class: vsftpd::backup
#
# Backups vsftpd data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $vsftpd_backup_data (true|false) : Set if you want to backup vsftpd's data. Default: As defined in $backup_data
# $vsftpd_backup_log (true|false) : Set if you want to backup vsftpd's logs. Default: As defined in $backup_log
# $vsftpd_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your vsftpd backups. Default: daily.
# $vsftpd_backup_target : Define how to reach (Ip, fqdn...) this host to backup vsftpd from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check vsftpd::params
#
# Usage:
# Automatically included if $backup=yes
#
class vsftpd::backup {

    include vsftpd::params

    backup { "vsftpd_data": 
        frequency => "${vsftpd::params::backup_frequency}",
        path      => "${vsftpd::params::datadir}",
        enabled   => "${vsftpd::params::backup_data_enable}",
        target    => "${vsftpd::params::backup_target_real}",
    }
    
    backup { "vsftpd_logs": 
        frequency => "${vsftpd::params::backup_frequency}",
        path      => "${vsftpd::params::logdir}",
        enabled   => "${vsftpd::params::backup_log_enable}",
        target    => "${vsftpd::params::backup_target_real}",
    }

}
