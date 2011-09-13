# Class: mysql::params
#
# Sets internal variables and defaults for mysql module
# This class is automatically loaded in all the classes that use the values set here 
#
class mysql::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

    $random_password = inline_template("<%= (1..25).collect{|a| (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + %w(# % & * + - : = ? @ ^ _))[rand(75)] }.join %>")

    $root_password = $mysql_root_password ? {
         ''      => "",
         auto    => "$random_password",
         default => "$mysql_root_password",
    }

    $logfile = $operatingsystem ? {
        default => "/var/log/mysqld.log",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "mysql-server",
    }

    $packagename_client = $operatingsystem ? {
        redhat  => "mysql",
        centos  => "mysql",
        default => "mysql-client",
    }

    $servicename = $operatingsystem ? {
        redhat  => "mysqld",
        centos  => "mysqld",
        default => "mysql",
    }

    $processname = $operatingsystem ? {
        default => "mysqld",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $status = $operatingsystem ? {
        default => '/etc/init.d/mysql status',
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/mysql/my.cnf",
        ubuntu  => "/etc/mysql/my.cnf",
        default => "/etc/my.cnf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/mysql/conf.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/mysql",
        ubuntu  => "/etc/default/mysql",
        default => "/etc/sysconfig/mysqld",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default  => "/var/run/mysqld/mysqld.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/mysql",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/mysql",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "3306"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) mysql::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $mysql_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $mysql_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$mysql_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $mysql_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${mysql_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in mysql::monitor class
    $monitor_url_pattern = $mysql_monitor_url_pattern ? {
        ''      => "OK",
        default => "${mysql_monitor_url_pattern}",
    }

    # If mysql port monitoring is enabled 
    $monitor_port_enable = $mysql_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $mysql_monitor_port,
    }

    # If mysql url monitoring is enabled 
    $monitor_url_enable = $mysql_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $mysql_monitor_url,
    }

    # If mysql process monitoring is enabled 
    $monitor_process_enable = $mysql_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $mysql_monitor_process,
    }

    # If mysql plugin monitoring is enabled 
    $monitor_plugin_enable = $mysql_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $mysql_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) mysql::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $mysql_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$mysql_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $mysql_backup_frequency ? {
        ''      => "daily",
        default => "$mysql_backup_frequency",
    }

    # If mysql data have to be backed up
    $backup_data_enable = $mysql_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $mysql_backup_data,
    }

    # If mysql logs have to be backed up
    $backup_log_enable = $mysql_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $mysql_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) mysql::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $mysql_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$mysql_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $mysql_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$mysql_firewall_destination",
    }

## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }

}
