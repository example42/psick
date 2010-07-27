# Class: dashboard::backup
#
# Backups dashboard data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include dashboard::backup
#
class dashboard::backup {

# If you want set the mailbox directory (here /home) and enable it
    backup { "dashboard_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/home",
        },        
        enabled    => false,
        host => $fqdn,
    }

}
