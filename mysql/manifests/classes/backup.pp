# Class: mysql::backup
#
# Backups mysql data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include mysql::backup
#
class mysql::backup {

    backup { "mysql_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            default => "/var/lib/mysql",
        },        
        enabled    => true,
        host => $fqdn,
    }
    
}
