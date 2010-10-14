# Class: nrpe::backup
#
# Backups nrpe data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $nrpe_backup_data (true|false) : Set if you want to backup nrpe's data. Default: As defined in $backup_data
# $nrpe_backup_log (true|false) : Set if you want to backup nrpe's logs. Default: As defined in $backup_log
# $nrpe_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your nrpe backups. Default: daily.
# $nrpe_backup_target : Define how to reach (Ip, fqdn...) this host to backup nrpe from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check nrpe::params
#
# Usage:
# Automatically included if $backup=yes
#
class nrpe::backup {

    include nrpe::params

    backup { "nrpe_data": 
        frequency => "${nrpe::params::backup_frequency}",
        path      => "${nrpe::params::datadir}",
        enabled   => "${nrpe::params::backup_data_enable}",
        target    => "${nrpe::params::backup_target_real}",
    }
    
    backup { "nrpe_logs": 
        frequency => "${nrpe::params::backup_frequency}",
        path      => "${nrpe::params::logdir}",
        enabled   => "${nrpe::params::backup_log_enable}",
        target    => "${nrpe::params::backup_target_real}",
    }

    # Include project specific backup class if $my_project is set
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::nrpe::backup" }
            default: { include "nrpe::backup::${my_project}" }
        }
    }

}
