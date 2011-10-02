# Class: sysklogd::params
#
# Sets internal variables and defaults for sysklogd module
# This class is loaded in all the classes that use the values set here 
#
class sysklogd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of sysklogd server
#    $server = $sysklogd_server ? {
#        ''      => "sysklogd",
#        default => "${sysklogd_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWsysklogd",
        debian  => "sysklogd",
        ubuntu  => "sysklogd",
        default => "sysklogd",
    }

    $servicename = $operatingsystem ? {
        default => "syslog",
    }

    $processname = $operatingsystem ? {
        default => "syslogd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/syslog.conf",
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
        default => "/etc/syslog",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/syslog",
        ubuntu  => "/etc/default/syslog",
        default => "/etc/sysconfig/syslog",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/syslogd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/sysklogd",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/syslog",
        ubuntu  => "/var/log/syslog",
        default => "/var/log/messages",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "udp"
    $port = "53"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) sysklogd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $sysklogd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $sysklogd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$sysklogd_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $sysklogd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${sysklogd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in sysklogd::monitor class
    $monitor_url_pattern = $sysklogd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${sysklogd_monitor_url_pattern}",
    }

    # If sysklogd port monitoring is enabled 
    $monitor_port_enable = $sysklogd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $sysklogd_monitor_port,
    }

    # If sysklogd url monitoring is enabled 
    $monitor_url_enable = $sysklogd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $sysklogd_monitor_url,
    }

    # If sysklogd process monitoring is enabled 
    $monitor_process_enable = $sysklogd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $sysklogd_monitor_process,
    }

    # If sysklogd plugin monitoring is enabled 
    $monitor_plugin_enable = $sysklogd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $sysklogd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) sysklogd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $sysklogd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$sysklogd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $sysklogd_backup_frequency ? {
        ''      => "daily",
        default => "$sysklogd_backup_frequency",
    }

    # If sysklogd data have to be backed up
    $backup_data_enable = $sysklogd_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $sysklogd_backup_data,
    }

    # If sysklogd logs have to be backed up
    $backup_log_enable = $sysklogd_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $sysklogd_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) sysklogd::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $sysklogd_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$sysklogd_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $sysklogd_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$sysklogd_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $sysklogd_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $sysklogd_firewall_enable,
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
