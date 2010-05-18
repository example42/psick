# Class: mailscanner::backup
#
# Backups mailscanner data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include mailscanner::backup
#
class mailscanner::backup {

    backup { "mailscanner_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/spool/mailscanner",
        },        
        enabled    => true,
        host => $fqdn,
    }
    
}
