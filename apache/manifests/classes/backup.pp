# Class: apache::backup
#
# Backups apache data directory and, optionally, logs (must be enabled)
# It's automatically included if $backup=yes
#
# Usage:
# include apache::backup
#
class apache::backup {

    backup { "apache_data": 
        frequency => daily,
        path    => $operatingsystem ?{
            debian  => "/var/www",
            ubuntu  => "/var/www",
            suse    => "/srv/www",
            default => "/var/www/html",
        },        
        enabled    => true,
        host => $fqdn,
    }
    

    backup { "apache_logs": 
        frequency => daily,
        path    => $operatingsystem ?{
            debian  => "/var/log/apache2",
            ubuntu  => "/var/log/apache2",
            suse    => "/var/log/apache2",
            default => "/var/log/httpd",
        },        
        enabled    => false,
        host => $fqdn,
    }
    
}
