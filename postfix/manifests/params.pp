# Class: postfix::params
#
# Sets internal variables and defaults for postfix module
# This class is automatically loaded in all the classes that use the values set here 
#
class postfix::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Postfix mydestination. Added to <%= fqdn =>, localhost.<%= domain => , localhost
    $mydestination = $postfix_mydestination ? {
        ''      => "",
        default => "${postfix_mydestination}",
    }

## Postfix relayhost. 
    $relayhost = $postfix_relayhost ? {
        ''      => "",
        default => "${postfix_relayhost}",
    }

## Postfix mynetworks. Added to 127.0.0.0/8
    $mynetworks = $postfix_mynetworks ? {
        ''      => "",
        default => "${postfix_mynetworks}",
    }

## Postfix inet_interfaces
    $inet_interfaces = $postfix_inet_interfaces ? {
        ''      => "localhost",
        default => "${postfix_inet_interfaces}",
    }

## Mysql User for Postfix with Mysql support. Used also in other modules.
    $mysqluser = $postfix_mysqluser ? {
        ''      => "postfix",
        default => "${postfix_mysqluser}",
    }

## Mysql Password for Postfix with Mysql support. Used also in other modules.
    $mysqlpassword = $postfix_mysqlpassword ? {
        ''      => "postfixpw!",
        default => "${postfix_mysqlpassword}",
    }

## Mysql Server for Postfix with Mysql support. Used also in other modules.
    $mysqlhost = $postfix_mysqlhost ? {
        ''      => "localhost",
        default => "${postfix_mysqlhost}",
    }

## Mysql database name for Postfix with Mysql support. Used also in other modules.
    $mysqldbname = $postfix_mysqldbname ? {
        ''      => "postfix",
        default => "${postfix_mysqldbname}",
    }

# Postfix Admin Download URL (Default: The official one)
    $postfixadmin_url = $postfix_postfixadmin_url ? {
        ""      => "http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.3.2/postfixadmin-2.3.2.tar.gz",
        default => $postfix_postfixadmin_url ,
    }

# Postfix Admin Version
    $postfixadmin_dirname = $postfix_postfixadmin_dirname ? {
        ""      => "postfixadmin-2.3.2",
        default => $postfix_postfixadmin_dirname ,
    }

## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

# Location of postfix admin configuration file. Used in postfix::postfixadmin
    $postfixadminconf = $operatingsystem ? {
        debian  => "/var/www/postfixadmin/config.inc.php",
        ubuntu  => "/var/www/postfixadmin/config.inc.php",
        suse    => "/srv/www/postfixadmin/config.inc.php",
        default => "/var/www/html/postfixadmin/config.inc.php",
    }

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWpostfix",
        default => "postfix",
    }

    $servicename = $operatingsystem ? {
        default => "postfix",
    }

    $processname = $operatingsystem ? {
        default => "master",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        default => "/etc/postfix/main.cf",
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
        freebsd => "/usr/local/etc/postfix/",
        default => "/etc/postfix",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/postfix",
        ubuntu  => "/etc/default/postfix",
        default => "/etc/sysconfig/postfix",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/postfix.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/spool/postfix",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/postfix",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "25"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) postfix::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $postfix_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $postfix_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$postfix_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $postfix_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${postfix_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in postfix::monitor class
    $monitor_url_pattern = $postfix_monitor_url_pattern ? {
        ''      => "OK",
        default => "${postfix_monitor_url_pattern}",
    }

    # If postfix port monitoring is enabled 
    $monitor_port_enable = $postfix_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $postfix_monitor_port,
    }

    # If postfix url monitoring is enabled 
    $monitor_url_enable = $postfix_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $postfix_monitor_url,
    }

    # If postfix process monitoring is enabled 
    $monitor_process_enable = $postfix_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $postfix_monitor_process,
    }

    # If postfix plugin monitoring is enabled 
    $monitor_plugin_enable = $postfix_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        },
        default => $postfix_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) postfix::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $postfix_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$postfix_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $postfix_backup_frequency ? {
        ''      => "daily",
        default => "$postfix_backup_frequency",
    }

    # If postfix data have to be backed up
    $backup_data_enable = $postfix_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $postfix_backup_data,
    }

    # If postfix logs have to be backed up
    $backup_log_enable = $postfix_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $postfix_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) postfix::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $postfix_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$postfix_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $postfix_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$postfix_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $postfix_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $postfix_firewall_enable,
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
