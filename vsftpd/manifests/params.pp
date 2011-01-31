# Class: vsftpd::params
#
# Sets internal variables and defaults for vsftpd module
# This class is automatically loaded in all the classes that use the values set here 
#
class vsftpd::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Full hostname of vsftpd server
#    $server = $vsftpd_server ? {
#        ''      => "vsftpd",
#        default => "${vsftpd_server}",
#    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $listen = $vsftpd_standalone ? {
        ""    => "YES",
        true  => "YES",
        false => "NO",
    }

    $anonymous_enable = $vsftpd_anonymous_enable ? {
        ""    => "NO",
        true  => "YES",
        false => "NO",
    }

    $local_enable = $vsftpd_local_user_enable ? {
        ""    => "YES",
        true  => "YES",
        false => "NO",
    }

    $write_enable = $vsftpd_write_enable ? {
        ""    => "YES",
        true  => "YES",
        false => "NO",
    }

    $xferlog_enable = $vsftpd_log_transfer ? {
        ""    => "YES",
        true  => "YES",
        false => "NO",
    }

    $xferlog_file = $vsftpd_log_file ? {
        ""      => "/var/log/vsftpd.log",
        default => "${vsftpd_log_file}",
    }

    $secure_chroot_dir = $vsftpd_chroot_dir ? {
        ""      => "/var/run/vsftpd",
        default => "${vsftpd_chroot_dir}",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWvsftpd",
        default => "vsftpd",
    }

    $servicename = $operatingsystem ? {
        default => "vsftpd",
    }

    $processname = $operatingsystem ? {
        default => "vsftpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/vsftpd/vsftpd.conf",
        debian  => "/etc/vsftpd.conf",
        ubuntu  => "/etc/vsftpd.conf",
        default => "/etc/vsftpd/vsftpd.conf",
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
        freebsd => "/usr/local/etc/vsftpd/",
        debian  => "/etc",
        ubuntu  => "/etc",
        default => "/etc/vsftpd",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/vsftpd",
        ubuntu  => "/etc/default/vsftpd",
        default => "/etc/sysconfig/vsftpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/vsftpd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/ftp/pub",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/vsftpd",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "21"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) vsftpd::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $vsftpd_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $vsftpd_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$vsftpd_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $vsftpd_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${vsftpd_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in vsftpd::monitor class
    $monitor_url_pattern = $vsftpd_monitor_url_pattern ? {
        ''      => "OK",
        default => "${vsftpd_monitor_url_pattern}",
    }

    # If vsftpd port monitoring is enabled 
    $monitor_port_enable = $vsftpd_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $vsftpd_monitor_port,
    }

    # If vsftpd url monitoring is enabled 
    $monitor_url_enable = $vsftpd_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $vsftpd_monitor_url,
    }

    # If vsftpd process monitoring is enabled 
    $monitor_process_enable = $vsftpd_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $vsftpd_monitor_process,
    }

    # If vsftpd plugin monitoring is enabled 
    $monitor_plugin_enable = $vsftpd_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        },
        default => $vsftpd_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) vsftpd::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $vsftpd_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$vsftpd_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $vsftpd_backup_frequency ? {
        ''      => "daily",
        default => "$vsftpd_backup_frequency",
    }

    # If vsftpd data have to be backed up
    $backup_data_enable = $vsftpd_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $vsftpd_backup_data,
    }

    # If vsftpd logs have to be backed up
    $backup_log_enable = $vsftpd_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $vsftpd_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) vsftpd::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $vsftpd_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$vsftpd_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $vsftpd_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$vsftpd_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $vsftpd_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $vsftpd_firewall_enable,
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
