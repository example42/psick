# Class: powerdns::params
#
# Sets internal variables and defaults for powerdns module
# This class is loaded in all the classes that use the values set here 
#
class powerdns::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Example: Full hostname of powerdns server
#    $server = $powerdns_server ? {
#        ''      => "powerdns",
#        default => "${powerdns_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWpowerdns",
        debian  => "pdns-server",
        ubuntu  => "pdns-server",
        default => "powerdns",
    }

    $packagename_sql = $operatingsystem ? {
        solaris => "CSWpdns-backend-mysql",
        debian  => "pdns-backend-mysql",
        ubuntu  => "pdns-backend-mysql",
        default => "pdns-backend-mysql",
    }
	
    $servicename = $operatingsystem ? {
        debian  => "pdns",
        ubuntu  => "pdns",
        default => "pdns",
    }

    $processname = $operatingsystem ? {
        default => "pdns_server",
    }

    $hasstatus = $operatingsystem ? {
        debian  => true,
        ubuntu  => true,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/powerdns/powerdns.conf",
        default => "/etc/powerdns/pdns.conf",
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
        default => "/etc/powerdns",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/pdns",
        ubuntu  => "/etc/default/pdns",
        default => "/etc/sysconfig/powerdns",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/pdns.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/powerdns",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/syslog",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "udp"
    $port = "53"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) powerdns::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $powerdns_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $powerdns_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$powerdns_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $powerdns_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${powerdns_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in powerdns::monitor class
    $monitor_url_pattern = $powerdns_monitor_url_pattern ? {
        ''      => "OK",
        default => "${powerdns_monitor_url_pattern}",
    }

    # If powerdns port monitoring is enabled 
    $monitor_port_enable = $powerdns_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $powerdns_monitor_port,
    }

    # If powerdns url monitoring is enabled 
    $monitor_url_enable = $powerdns_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $powerdns_monitor_url,
    }

    # If powerdns process monitoring is enabled 
    $monitor_process_enable = $powerdns_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $powerdns_monitor_process,
    }

    # If powerdns plugin monitoring is enabled 
    $monitor_plugin_enable = $powerdns_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $powerdns_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) powerdns::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $powerdns_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$powerdns_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $powerdns_backup_frequency ? {
        ''      => "daily",
        default => "$powerdns_backup_frequency",
    }

    # If powerdns data have to be backed up
    $backup_data_enable = $powerdns_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $powerdns_backup_data,
    }

    # If powerdns logs have to be backed up
    $backup_log_enable = $powerdns_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $powerdns_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) powerdns::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $powerdns_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$powerdns_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $powerdns_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$powerdns_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $powerdns_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $powerdns_firewall_enable,
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
