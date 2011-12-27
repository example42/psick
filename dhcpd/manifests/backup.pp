# Class: dhcpd::backup
#
# Backups dhcpd data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $dhcpd_backup_data (true|false) : Set if you want to backup dhcpd's data. Default: As defined in $backup_data
# $dhcpd_backup_log (true|false) : Set if you want to backup dhcpd's logs. Default: As defined in $backup_log
# $dhcpd_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your dhcpd backups. Default: daily.
# $dhcpd_backup_target : Define how to reach (Ip, fqdn...) this host to backup dhcpd from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check dhcpd::params
#
# Usage:
# Automatically included if $backup=yes
#
class dhcpd::backup {

    include dhcpd::params

    backup { "dhcpd_data": 
        frequency => "${dhcpd::params::backup_frequency}",
        path      => "${dhcpd::params::datadir}",
        enabled   => "${dhcpd::params::backup_data_enable}",
        target    => "${dhcpd::params::backup_target_real}",
    }
    
    backup { "dhcpd_logs": 
        frequency => "${dhcpd::params::backup_frequency}",
        path      => "${dhcpd::params::logdir}",
        enabled   => "${dhcpd::params::backup_log_enable}",
        target    => "${dhcpd::params::backup_target_real}",
    }

}
