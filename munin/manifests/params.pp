# Class: munin::params
#
# Sets internal variables and defaults for munin module
# This class is automatically loaded in all the classes that use the values set here 
#
class munin::params  {

    require common

## Full hostname of munin server
    $server = $munin_server ? {
        ''      => "127.0.0.1",
        default => "${munin_server}",
    }

## Is the node a munin gatherer?
    $server_local = $munin_server_local ? {
        yes     => "yes",
        true    => "yes",
        "true"  => "yes",
        default => "no",
    }

# Define according to what criteria you want to organize what nodes your Munin servers monitor
# Note that you need to add in the list below your own variable name, if is not already provided.
    $grouptag = $munin_grouplogic ? {
         ''            => "",
         'type'        => $type,
         'env'         => $env,
         'environment' => $environment,
         'zone'        => $zone,
         'site'        => $site,
         'role'        => $role,
    }

# Define if you want to include extra plugins
    $plugins = $munin_plugins ? {
        '' => "no",
        default => "${munin_plugins}",
    }

## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $packagename_perlcidr = $operatingsystem ? {
        /(?i:centos|redhat|scientific)/ => $common::osver ? {
                4        => "perl-Net-CIDR-Lite",
                default  => "perl-Net-CIDR",
            },
        default => "libnet-cidr-perl",
    }

    $packagename_server = $operatingsystem ? {
        default => "munin",
    }

    $configfile_server = $operatingsystem ? {
        default => "/etc/munin/munin.conf",
    }

    $includedir = "/etc/munin/munin-conf.d"

    $webdir = $operatingsystem ? {
        debian  => "/var/cache/munin/www",
        ubuntu  => "/var/cache/munin/www",
        default => "/var/www/html/munin",
    }

    $pluginsdir = $operatingsystem ? {
        default => "/usr/share/munin/plugins",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "munin-node",
    }

    $servicename = $operatingsystem ? {
        default => "munin-node",
    }

    $processname = $operatingsystem ? {
        default => "munin-node",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => true,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/munin/munin-node.conf",
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
        default => "/etc/munin",
    }

    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/munin/munin-node.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/munin",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/munin",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "4949"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) munin::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $munin_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $munin_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$munin_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $munin_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${munin_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in munin::monitor class
    $monitor_url_pattern = $munin_monitor_url_pattern ? {
        ''      => "OK",
        default => "${munin_monitor_url_pattern}",
    }

    # If munin port monitoring is enabled 
    $monitor_port_enable = $munin_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $munin_monitor_port,
    }

    # If munin url monitoring is enabled 
    $monitor_url_enable = $munin_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $munin_monitor_url,
    }

    # If munin process monitoring is enabled 
    $monitor_process_enable = $munin_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $munin_monitor_process,
    }

    # If munin plugin monitoring is enabled 
    $monitor_plugin_enable = $munin_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $munin_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) munin::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $munin_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$munin_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $munin_backup_frequency ? {
        ''      => "daily",
        default => "$munin_backup_frequency",
    }

    # If munin data have to be backed up
    $backup_data_enable = $munin_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $munin_backup_data,
    }

    # If munin logs have to be backed up
    $backup_log_enable = $munin_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $munin_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) munin::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $munin_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$munin_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $munin_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$munin_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $munin_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $munin_firewall_enable,
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
