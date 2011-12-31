# Class: openssh::params
#
# Defines openssh parameters
# In this class are defined as variables values that are used in other openssh classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class openssh::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)


## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "openssh-server",
    }

    $servicename = $operatingsystem ? {
        debian  => "ssh",
        ubuntu  => "ssh",
        /(?i:CentOS|RedHat|Scientific)/ => "sshd",
    }

    $processname = $operatingsystem ? {
        default  => "sshd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/ssh/sshd_config",
    }

    $configfile_mode = $operatingsystem ? {
        default => "600",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/ssh",
        ubuntu  => "/etc/default/ssh",
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/sysconfig/sshd",
    }   

    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/sshd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/etc/ssh/",
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
    $protocol = "tcp"
    $port = $openssh_port ? {
         ''      => "22",
         default => "$openssh_port",
    }


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) openssh::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $openssh_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $openssh_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$openssh_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $openssh_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${openssh_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in openssh::monitor class
    $monitor_url_pattern = $openssh_monitor_url_pattern ? {
        ''      => "OK",
        default => "${openssh_monitor_url_pattern}",
    }

    # If openssh port monitoring is enabled 
    $monitor_port_enable = $openssh_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $openssh_monitor_port,
    }

    # If openssh url monitoring is enabled 
    $monitor_url_enable = $openssh_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $openssh_monitor_url,
    }

    # If openssh process monitoring is enabled 
    $monitor_process_enable = $openssh_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $openssh_monitor_process,
    }

    # If openssh plugin monitoring is enabled 
    $monitor_plugin_enable = $openssh_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $openssh_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) openssh::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $openssh_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$openssh_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $openssh_backup_frequency ? {
        ''      => "daily",
        default => "$openssh_backup_frequency",
    }

    # If openssh data have to be backed up
    $backup_data_enable = $openssh_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $openssh_backup_data,
    }

    # If openssh logs have to be backed up
    $backup_log_enable = $openssh_backup_log ? {
        ''      => $backup_log ? {
           ''      => false,
           default => $backup_log,
        },
        default => $openssh_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) openssh::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $openssh_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$openssh_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $openssh_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$openssh_firewall_destination",
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
