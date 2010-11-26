# Class: dovecot::params
#
# Sets internal variables and defaults for dovecot module
# This class is automatically loaded in all the classes that use the values set here 
#
class dovecot::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Full hostname of dovecot server
#    $server = $dovecot_server ? {
#        ''      => "dovecot",
#        default => "${dovecot_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "dovecot-imapd",
        ubuntu  => "dovecot-imapd",
        default => "dovecot",
    }

    $servicename = $operatingsystem ? {
        default => "dovecot",
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/dovecot/dovecot.conf",
        ubuntu  => "/etc/dovecot/dovecot.conf",
        default => "/etc/dovecot.conf",
    }

    $processname = $operatingsystem ? {
        default => "dovecot",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
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
        freebsd => "/usr/local/etc/dovecot/",
        default => "/etc/dovecot",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/dovecotd",
        ubuntu  => "/etc/default/dovecotd",
        default => "/etc/sysconfig/dovecotd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/dovecotd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/dovecot",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/dovecot",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) dovecot::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $dovecot_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $dovecot_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$dovecot_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $dovecot_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${dovecot_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in dovecot::monitor class
    $monitor_url_pattern = $dovecot_monitor_url_pattern ? {
        ''      => "OK",
        default => "${dovecot_monitor_url_pattern}",
    }

    # If dovecot port monitoring is enabled 
    $monitor_port_enable = $dovecot_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $dovecot_monitor_port,
    }

    # If dovecot url monitoring is enabled 
    $monitor_url_enable = $dovecot_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => true,
           default => $monitor_url,
        },
        default => $dovecot_monitor_url,
    }

    # If dovecot process monitoring is enabled 
    $monitor_process_enable = $dovecot_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $dovecot_monitor_process,
    }

    # If dovecot plugin monitoring is enabled 
    $monitor_plugin_enable = $dovecot_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        },
        default => $dovecot_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) dovecot::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $dovecot_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$dovecot_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $dovecot_backup_frequency ? {
        ''      => "daily",
        default => "$dovecot_backup_frequency",
    }

    # If dovecot data have to be backed up
    $backup_data_enable = $dovecot_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $dovecot_backup_data,
    }

    # If dovecot logs have to be backed up
    $backup_log_enable = $dovecot_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $dovecot_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) dovecot::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $dovecot_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$dovecot_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $dovecot_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$dovecot_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $dovecot_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $dovecot_firewall_enable,
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
