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

    $http_port_options = $squid_port_options ? {
        default => "${squid_port_options}"
    }

    $icp_port = $squid_icp_port ? {
        ''      => "3130",
        default => "${squid_icp_port}",
    }

    $type_accelerator = $squid_type_accelerator ? {
        ''      => "on",
        false   => "on",
        true    => "off",
    }

    $cache_hostname = $squid_cache_hostname ? {
        ''      => "localhost",
        default => "${squid_cache_hostname}",
    }

    $default_acls = $squid_default_acls ? {
        ''      => true,
        default => "${squid_default_acls}",
    }

    $custom_acls = $squid_custom_acls ? {
        ''      => "",
        default => $squid_custom_acls
    }

    $default_http_access = $squid_default_http_access ? {
        ''      => true,
        default => "${squid_default_http_access}",
    }

    $custom_http_accesses = $squid_custom_http_accesses ? {
        ''      => "",
        default => $squid_custom_http_accesses,
    }

    $auth_param = $squid_auth_param ? {
        ''      => "",
        default => $squid_auth_param,
    }

    $cache_dir = $squid_cache_dir ? {
        ''      => "/var/spool/squid",
        default => "${squid_cache_dir}",
    }

    $cache_dir_type = $squid_cache_dir_type ? {
        ''      => "ufs",
        default => "${squid_cache_dir_type}",
    }

    $cache_size = $squid_cache_size ? {
        ''      => "100",
        default => "${squid_cache_size}",
    }

    $cache_mem = $squid_cache_mem ? {
        ''      => "8",
        default => "${squid_cache_mem}",
    }

    $cache_parent = $squid_cache_parent ? {
        default => "${squid_cache_parent}",
    }

    $cache_parent_port = $squid_cache_parent_port ? {
        ''      => "3128",
        default => "${squid_cache_parent_port}"
    }

    $cache_parent_icp_port = $squid_cache_parent_icp_port ? {
        ''      => "3130",
        default => "${squid_cache_parent_icp_port}",
    }

    $cache_parent_options = $squid_cache_parent_options ? {
        ''      => "proxy-only default",
        default => "${squid_cache_parent_options}",
    }

    $cache_peers = $squid_cache_peers ? {
        ''      => "",
        default => $squid_cache_peers
    }

    $cache_peers_port = $squid_cache_peers_port ? {
        ''      => "3128",
        default => "${squid_cache_peers_port}",
    }

    $cache_peers_icp_port = $squid_cache_peers_icp_port ? {
        ''      => "3130",
        default => "${squid_cache_peers_icp_port}",
    }

    $cache_peers_options = $squid_cache_peers_options ? {
        ''      => "proxy-only",
        default => "${squid_cache_peers_options}",
    }

    $cache_log_dir = $squid_cache_log_dir ? {
        ''      => $operatingsystem ? {
            ubuntu => "/var/log/squid3",
            debian => "/var/log/squid3",
            default => "/var/log/squid",
            },
        default => "${squid_cache_log_dir}",
    }

    $cache_log_rotate = $squid_cache_log_rotate ? {
        ''      => "0",
        default => "${squid_cache_log_rotate}",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWsquid",
        debian  => "squid3",
        ubuntu  => "squid3",
        default => "squid",
    }

    $servicename = $operatingsystem ? {
        debian  => "squid3",
        ubuntu  => "squid3",
        default => "squid",
    }

    $processname = $operatingsystem ? {
        debian  => "squid3",
        ubuntu  => "squid3",
        default => "squid",
    }

    $processuser = $operatingsystem ? {
        debian  => "proxy",
        ubuntu  => "proxy",
        default => "squid",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/squid/squid.conf",
        debian  => "/etc/squid3/squid.conf",
        ubuntu  => "/etc/squid3/squid.conf",
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

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
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
           ''      => false,
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
  
    # Frequency of backups
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
