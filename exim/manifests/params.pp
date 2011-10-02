# Class: exim::params
#
# Sets internal variables and defaults for exim module
# This class is loaded in all the classes that use the values set here 
#
class exim::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of exim server
#    $server = $exim_server ? {
#        ''      => "exim",
#        default => "${exim_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "exim4",
        ubuntu  => "exim4",
        default => "exim",
    }

    $servicename = $operatingsystem ? {
        debian  => "exim4",
        ubuntu  => "exim4",
        default => "exim",
    }

    $processname = $operatingsystem ? {
        default => "exim",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    # For semplicity and lack of time to deploy a sensible configuration we consider as exim config file on Ubuntu/Debian
    # the debconf file, which is evaluated when the service is started. This file has not the format and the syntax of the official exim file.
    $configfile = $operatingsystem ? {
        debian  => "/etc/exim4/update-exim4.conf.conf",
        ubuntu  => "/etc/exim4/update-exim4.conf.conf",
        default => "/etc/exim/exim.conf",
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
        default => "/etc/exim",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/exim",
        ubuntu  => "/etc/default/exim",
        default => "/etc/sysconfig/exim",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/eximd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/exim",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/exim",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) exim::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $exim_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $exim_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$exim_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $exim_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${exim_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in exim::monitor class
    $monitor_url_pattern = $exim_monitor_url_pattern ? {
        ''      => "OK",
        default => "${exim_monitor_url_pattern}",
    }

    # If exim port monitoring is enabled 
    $monitor_port_enable = $exim_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $exim_monitor_port,
    }

    # If exim url monitoring is enabled 
    $monitor_url_enable = $exim_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $exim_monitor_url,
    }

    # If exim process monitoring is enabled 
    $monitor_process_enable = $exim_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $exim_monitor_process,
    }

    # If exim plugin monitoring is enabled 
    $monitor_plugin_enable = $exim_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $exim_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) exim::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $exim_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$exim_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $exim_backup_frequency ? {
        ''      => "daily",
        default => "$exim_backup_frequency",
    }

    # If exim data have to be backed up
    $backup_data_enable = $exim_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $exim_backup_data,
    }

    # If exim logs have to be backed up
    $backup_log_enable = $exim_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $exim_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) exim::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $exim_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$exim_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $exim_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$exim_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $exim_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $exim_firewall_enable,
    }

}
