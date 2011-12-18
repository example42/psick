# Class: apache::params
#
# Defines apache parameters
# In this class are defined as variables values that are used in other users classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class apache::params  {
## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
#

# EXTRA VARIABLES
    $vdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20/conf.d",
        ubuntu  => "/etc/apache2/sites-available",
        debian  => "/etc/apache2/sites-available",
        /(?i:CentOS|RedHat|Scientific)/ => "/etc/httpd/conf.d",
    }

    $packagename_modssl = $operatingsystem ? {
        debian  => "libapache-mod-ssl",
        ubuntu  => "libapache-mod-ssl",
        default => "mod_ssl",
    }


# MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)
    $packagename = $operatingsystem ? {
        freebsd => "apache20",
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicename = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $servicepattern = $operatingsystem ? {
        debian  => "/usr/sbin/apache2",
        ubuntu  => "/usr/sbin/apache2",
        default => "/usr/sbin/httpd",
    }

    $processname = $operatingsystem ? {
        debian  => "apache2",
        ubuntu  => "apache2",
        default => "httpd",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $username = $operatingsystem ? {
        debian  => "www-data",
        ubuntu  => "www-data",
        default => "apache",
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20/httpd.conf",
        ubuntu  => "/etc/apache2/apache2.conf",
        debian  => "/etc/apache2/apache2.conf",
        default => "/etc/httpd/conf/httpd.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        freebsd => "wheel",
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/apache20",
        ubuntu  => "/etc/apache2",
        debian  => "/etc/apache2",
        default => "/etc/httpd/conf",
    }

    $documentroot = $operatingsystem ? {
        debian  => "/var/www",
        ubuntu  => "/var/www",
        suse    => "/srv/www",
        default => "/var/www/html",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/apache2",
        ubuntu  => "/etc/default/apache2",
        default => "/etc/sysconfig/httpd",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        ubuntu  => "/var/run/apache2.pid",
        debian  => "/var/run/apache2.pid",
        default => "/var/run/httpd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "${documentroot}",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        debian  => "/var/log/apache2",
        ubuntu  => "/var/log/apache2",
        default => "/var/log/httpd",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"



## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) apache::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $apache_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $apache_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$apache_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl_real = $apache_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${apache_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in apache::monitor class
    $monitor_url_pattern = $apache_monitor_url_pattern ? {
        ''      => "OK",
        default => "${apache_monitor_url_pattern}",
    }

    # If apache port monitoring is enabled 
    $monitor_port_enable = $apache_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $apache_monitor_port,
    }

    # If apache url monitoring is enabled 
    $monitor_url_enable = $apache_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $apache_monitor_url,
    }

    # If apache process monitoring is enabled 
    $monitor_process_enable = $apache_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $apache_monitor_process,
    }

    # If apache plugin monitoring is enabled 
    $monitor_plugin_enable = $apache_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $apache_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) apache::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $apache_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$apache_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $apache_backup_frequency ? {
        ''      => "daily",
        default => "$apache_backup_frequency",
    }

    # If apache data have to be backed up
    $backup_data_enable = $apache_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $apache_backup_data,
    }

    # If apache logs have to be backed up
    $backup_log_enable = $apache_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $apache_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) apache::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $apache_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$apache_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $apache_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$apache_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $apache_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $apache_firewall_enable,
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
