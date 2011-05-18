# Class: dhcpd::params
#
# Sets internal variables and defaults for dhcpd module
# This class is loaded in all the classes that use the values set here 
#
class dhcpd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "dhcp3-server",
        ubuntu  => "dhcp3-server",
        default => "dhcp",
    }

    $servicename = $operatingsystem ? {
        debian  => "dhcp3-server",
        ubuntu  => "dhcp3-server",
        default => "dhcpd",
    }

    $processname = $operatingsystem ? {
        debian  => "dhcpd3",
        ubuntu  => "dhcpd3",
        default => "dhcpd",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/dhcp3/dhcpd.conf",
        ubuntu  => "/etc/dhcp3/dhcpd.conf",
        default => "/etc/dhcpd.conf",
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
        debian  => "/etc/dhcp3",
        ubuntu  => "/etc/dhcp3",
        default => "/etc/dhcp",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/dhcp3-server",
        ubuntu  => "/etc/default/dhcp3-server",
        default => "/etc/sysconfig/dhcpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        debian  => "/var/run/dhcp3-server/dhcpd.pid",
        ubuntu  => "/var/run/dhcp3-server/dhcpd.pid",
        default => "/var/run/dhcpd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        debian  => "/var/lib/dhcp3",
        ubuntu  => "/var/lib/dhcp3",
        default => "/var/lib/dhcpd",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "udp"
    $port = "67"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) dhcpd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $dhcpd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $dhcpd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$dhcpd_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $dhcpd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${dhcpd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in dhcpd::monitor class
    $monitor_url_pattern = $dhcpd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${dhcpd_monitor_url_pattern}",
    }

    # If dhcpd port monitoring is enabled 
    $monitor_port_enable = $dhcpd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $dhcpd_monitor_port,
    }

    # If dhcpd url monitoring is enabled 
    $monitor_url_enable = $dhcpd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $dhcpd_monitor_url,
    }

    # If dhcpd process monitoring is enabled 
    $monitor_process_enable = $dhcpd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $dhcpd_monitor_process,
    }

    # If dhcpd plugin monitoring is enabled 
    $monitor_plugin_enable = $dhcpd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $dhcpd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) dhcpd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $dhcpd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$dhcpd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $dhcpd_backup_frequency ? {
        ''      => "daily",
        default => "$dhcpd_backup_frequency",
    }

    # If dhcpd data have to be backed up
    $backup_data_enable = $dhcpd_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $dhcpd_backup_data,
    }

    # If dhcpd logs have to be backed up
    $backup_log_enable = $dhcpd_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $dhcpd_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) dhcpd::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $dhcpd_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$dhcpd_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $dhcpd_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$dhcpd_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $dhcpd_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $dhcpd_firewall_enable,
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
