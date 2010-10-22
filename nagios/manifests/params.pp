# Class: nagios::params
#
# Sets internal variables and defaults for nagios module
# This class is automatically loaded in all the classes that use the values set here 
#
class nagios::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Full hostname of nagios server
    $server = $nagios_server ? {
        ''      => "nagios",
        default => "${nagios_server}",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios3",
        default => "nagios",
    }

    $servicename = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios3",
        default => "nagios",
    }

    $processname = $operatingsystem ? {
        ubuntu  => "nagios3",
        debian  => "nagios3",
        default => "nagios",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        ubuntu  => "/etc/nagios/nagios.cfg",
        debian  => "/etc/nagios/nagios.cfg",
        default => "/etc/nagios/nagios.cfg",
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
        debian  => "/etc/nagios3",
        ubuntu  => "/etc/nagios3",
        default => "/etc/nagios",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/nagios3",
        ubuntu  => "/etc/default/nagios3",
        default => "/etc/sysconfig/nagios",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        debian  => "/var/run/nagios3/nagios3.pid",
        ubuntu  => "/var/run/nagios3/nagios3.pid",
        default => "/var/run/nagiosd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        debian  => "/var/lib/nagios3",
        ubuntu  => "/var/lib/nagios3",
        default => "/var/lib/nagios",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/nagios3",
        ubuntu  => "/var/log/nagios3",
        default => "/var/log/nagios",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    # $protocol = "tcp"
    # $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) nagios::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $nagios_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $nagios_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$nagios_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $nagios_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${nagios_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in nagios::monitor class
    $monitor_url_pattern = $nagios_monitor_url_pattern ? {
        ''      => "OK",
        default => "${nagios_monitor_url_pattern}",
    }

    # If nagios port monitoring is enabled 
    $monitor_port_enable = $nagios_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $nagios_monitor_port,
    }

    # If nagios url monitoring is enabled 
    $monitor_url_enable = $nagios_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $nagios_monitor_url,
    }

    # If nagios process monitoring is enabled 
    $monitor_process_enable = $nagios_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $nagios_monitor_process,
    }

    # If nagios plugin monitoring is enabled 
    $monitor_plugin_enable = $nagios_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $nagios_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) nagios::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $nagios_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$nagios_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $nagios_backup_frequency ? {
        ''      => "daily",
        default => "$nagios_backup_frequency",
    }

    # If nagios data have to be backed up
    $backup_data_enable = $nagios_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $nagios_backup_data,
    }

    # If nagios logs have to be backed up
    $backup_log_enable = $nagios_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $nagios_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) nagios::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $nagios_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$nagios_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $nagios_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$nagios_firewall_destination",
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
