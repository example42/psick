# Class: squid::params
#
# Sets internal variables and defaults for squid module
# This class is automatically loaded in all the classes that use the values set here 
#
class squid::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Full hostname of squid server
    $http_port = $squid_port ? {
        ''      => "3128",
        default => "${squid_port}",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWsquid",
        default => "squid",
    }

    $servicename = $operatingsystem ? {
        default => "squid",
    }

    $processname = $operatingsystem ? {
        default => "squid",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/squid/squid.conf",
        default => "/etc/squid/squid.conf",
    }

    $configfile_mode = $operatingsystem ? {
        debian  => "600",
        ubuntu  => "600",
        default => "640",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        debian  => "root",
        ubuntu  => "root",
        default => "squid",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/squid/",
        default => "/etc/squid",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/squid",
        ubuntu  => "/etc/default/squid",
        default => "/etc/sysconfig/squid",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/squid.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/spool/squid",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/squid",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "${http_port}"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) squid::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $squid_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $squid_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$squid_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $squid_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${squid_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in squid::monitor class
    $monitor_url_pattern = $squid_monitor_url_pattern ? {
        ''      => "OK",
        default => "${squid_monitor_url_pattern}",
    }

    # If squid port monitoring is enabled 
    $monitor_port_enable = $squid_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $squid_monitor_port,
    }

    # If squid url monitoring is enabled 
    $monitor_url_enable = $squid_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $squid_monitor_url,
    }

    # If squid process monitoring is enabled 
    $monitor_process_enable = $squid_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $squid_monitor_process,
    }

    # If squid plugin monitoring is enabled 
    $monitor_plugin_enable = $squid_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        },
        default => $squid_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) squid::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $squid_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$squid_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $squid_backup_frequency ? {
        ''      => "daily",
        default => "$squid_backup_frequency",
    }

    # If squid data have to be backed up
    $backup_data_enable = $squid_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $squid_backup_data,
    }

    # If squid logs have to be backed up
    $backup_log_enable = $squid_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $squid_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) squid::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $squid_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$squid_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $squid_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$squid_firewall_destination",
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
