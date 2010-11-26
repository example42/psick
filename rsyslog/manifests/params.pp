# Class: rsyslog::params
#
# Sets internal variables and defaults for rsyslog module
# This class is automatically loaded in all the classes that use the values set here 
#
class rsyslog::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Full hostname of rsyslog server
    $server = $syslog_server ? {
        ''      => "syslog.example42.com",
        default => "${syslog_server}",
    }

# Define if you want to use the Web Fronted Log Analyzer on the rsyslog server
# If you set "yes" here you'll probably want to add Mysql support
    $use_loganalyzer = $rsyslog_use_loganalyzer ? {
        ""      => "no",
        "true"  => "yes",
        true    => "yes",
        "yes"   => "yes",
        default => "no",
    }

# LogAnalyzer Download URL (Default: The official one)
    $loganalyzer_url = $rsyslog_loganalyzer_url ? {
        ""      => "http://download.adiscon.com/loganalyzer/loganalyzer-3.0.4.tar.gz",
        default => $rsyslog_loganalyzer_url ,
    }

# Log Analyzer Version
    $loganalyzer_dirname = $rsyslog_loganalyzer_dirname ? {
        ""      => "loganalyzer-3.0.4",
        default => $rsyslog_loganalyzer_dirname ,
    }


# Define Rsyslog DB backend 
    $db = $rsyslog_db ? {
        mysql   => "mysql",
        default => "",
    }

# Define Rsyslog DB name ($rsyslog_db_name). Default: syslog
    $db_name = $rsyslog_db_name ? {
        ''      => "syslog",
        default => "$rsyslog_db_name",
    }

# Define Rsyslog DB server ($rsyslog_db_server). Default: localhost
    $db_server = $rsyslog_db_server ? {
        ''      => "localhost",
        default => "$rsyslog_db_server",
    }

# Define Rsyslog DB user ($rsyslog_db_user). Default: root
    $db_user = $rsyslog_db_user ? {
        ''      => "root",
        default => "$rsyslog_db_user",
    }

# Define Rsyslog DB password ($rsyslog_db_password). Default: blank
    $db_password = $rsyslog_db_password ? {
        ''      => "",
        default => "$rsyslog_db_password",
    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)



## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "rsyslog",
    }

    $servicename = $operatingsystem ? {
        default => "rsyslog",
    }

    $processname = $operatingsystem ? {
        default => "rsyslogd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/rsyslog.conf",
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
        default => "/etc/rsyslog.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/rsyslog",
        ubuntu  => "/etc/default/rsyslog",
        default => "/etc/sysconfig/rsyslog",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/rsyslogd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/rsyslog",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "514"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) rsyslog::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $rsyslog_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $rsyslog_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$rsyslog_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $rsyslog_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${rsyslog_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in rsyslog::monitor class
    $monitor_url_pattern = $rsyslog_monitor_url_pattern ? {
        ''      => "OK",
        default => "${rsyslog_monitor_url_pattern}",
    }

    # If rsyslog port monitoring is enabled 
    $monitor_port_enable = $rsyslog_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $rsyslog_monitor_port,
    }

    # If rsyslog url monitoring is enabled 
    $monitor_url_enable = $rsyslog_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $rsyslog_monitor_url,
    }

    # If rsyslog process monitoring is enabled 
    $monitor_process_enable = $rsyslog_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $rsyslog_monitor_process,
    }

    # If rsyslog plugin monitoring is enabled 
    $monitor_plugin_enable = $rsyslog_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $rsyslog_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) rsyslog::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $rsyslog_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$rsyslog_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $rsyslog_backup_frequency ? {
        ''      => "daily",
        default => "$rsyslog_backup_frequency",
    }

    # If rsyslog data have to be backed up
    $backup_data_enable = $rsyslog_backup_data ? {
        ''      => $backup_data ? {
           ''      => false,
           default => $backup_data,
        },
        default => $rsyslog_backup_data,
    }

    # If rsyslog logs have to be backed up
    $backup_log_enable = $rsyslog_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $rsyslog_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) rsyslog::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $rsyslog_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$rsyslog_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $rsyslog_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$rsyslog_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $rsyslog_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $rsyslog_firewall_enable,
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
