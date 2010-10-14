# Class: activemq::params
#
# Sets internal variables and defaults for activemq module
# This class is automatically loaded in all the classes that use the values set here 
#
class activemq::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

    $admin_user = $activemq_admin_user ? {
        ''      => "admin",
        default => "${activemq_admin_user}",
    }

    $admin_password = $activemq_admin_password ? {
        ''      => "admin",
        default => "${activemq_admin_password}",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "activemq",
    }

    $servicename = $operatingsystem ? {
        default => "activemq",
    }

    $processname = $operatingsystem ? {
        default => "activemqd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/activemq/activemq.xml",
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
        default => "/etc/activemq",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/activemq",
        ubuntu  => "/etc/default/activemq",
        default => "/etc/sysconfig/activemq",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/activemq/activemq.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/log/activemq/activemq-data/",
        # default => "/var/cache/activemq/data",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/activemq/",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "6163"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) activemq::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $activemq_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $activemq_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$activemq_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $activemq_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${activemq_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in activemq::monitor class
    $monitor_url_pattern = $activemq_monitor_url_pattern ? {
        ''      => "OK",
        default => "${activemq_monitor_url_pattern}",
    }

    # If activemq port monitoring is enabled 
    $monitor_port_enable = $activemq_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $activemq_monitor_port,
    }

    # If activemq url monitoring is enabled 
    $monitor_url_enable = $activemq_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $activemq_monitor_url,
    }

    # If activemq process monitoring is enabled 
    $monitor_process_enable = $activemq_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $activemq_monitor_process,
    }

    # If activemq plugin monitoring is enabled 
    $monitor_plugin_enable = $activemq_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $activemq_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) activemq::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $activemq_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$activemq_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $activemq_backup_frequency ? {
        ''      => "daily",
        default => "$activemq_backup_frequency",
    }

    # If activemq data have to be backed up
    $backup_data_enable = $activemq_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $activemq_backup_data,
    }

    # If activemq logs have to be backed up
    $backup_log_enable = $activemq_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $activemq_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) activemq::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $activemq_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$activemq_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $activemq_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$activemq_firewall_destination",
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
