# Class: drupal::params
#
# Sets internal variables and defaults for drupal module
# This class is loaded in all the classes that use the values set here 
#
class drupal::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

## Download URL for Drupal's Drush
    $use_package  = $drupal_use_package ? {
        true   => "yes",
        "true" => "yes",
        "yes"   => "yes",
        default => "no",
    }

    $version  = $drupal_version ? {
        '5'     => "5",
        '6'     => "6",
        '7'     => "7",
        default => "7",
    }

    $drush_url  = $drupal_drush_url ? {
        ''      => "http://ftp.drupal.org/files/projects/drush-7.x-4.0.tar.gz",
        default => "${drupal_drush_url}",
    }

    $basedir = $use_package ? {
        yes  => $operatingsystem ? {
            debian  => "/usr/share/drupal6",
            ubuntu  => "/usr/share/drupal6",
            redhat  => "/usr/share/drupal",
            centos  => "/usr/share/drupal",
        },
        no   =>  $drupal_basedir ? {
            ''      => "/var/www/drupal",
            default => "${drupal_basedir}",
        },
    }

    # The directory where sites dir is placed.
    # (Some packages place it outside the basedir)
    $sitesdir = $use_package ? {
        yes  => $operatingsystem ? {
            debian  => "/etc/drupal/6/sites",
            ubuntu  => "/etc/drupal/6/sites",
            redhat  => "/etc/drupal",
            centos  => "/etc/drupal",
        },
        no   =>  $drupal_sitesdir ? {
            ''      => "$basedir/sites",
            default => "${drupal_sitesdir}",
        },
    }

    $extra  = $drupal_extra ? {
        true   => "yes",
        "true" => "yes",
        "yes"   => "yes",
        default => "no",
    }


## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)

    $drush_path = "$sitesdir/all/modules/drush/drush"

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWdrupal",
        debian  => "drupal",
        ubuntu  => "drupal",
        default => "drupal",
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/drupal/drupal.conf",
        default => "/etc/drupal/drupal.conf",
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
        default => "/etc/drupal",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/www/drupal",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/drupal",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "80"
    


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) drupal::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $drupal_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $drupal_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$drupal_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $drupal_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${drupal_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in drupal::monitor class
    $monitor_url_pattern = $drupal_monitor_url_pattern ? {
        ''      => "a", # Sane default. TO CUSTOMIZE
        default => "${drupal_monitor_url_pattern}",
    }

    # If drupal port monitoring is enabled 
    $monitor_port_enable = $drupal_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => false,
           default => $monitor_port,
        },
        default => $drupal_monitor_port,
    }

    # If drupal url monitoring is enabled 
    $monitor_url_enable = $drupal_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => true,
           default => $monitor_url,
        },
        default => $drupal_monitor_url,
    }

    # If drupal process monitoring is enabled 
    $monitor_process_enable = $drupal_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => false,
           default => $monitor_process,
        },
        default => $drupal_monitor_process,
    }

    # If drupal plugin monitoring is enabled 
    $monitor_plugin_enable = $drupal_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $drupal_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) drupal::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target_real = $drupal_backup_target ? {
        ''      => $backup_target ? {
           ''      => "${fqdn}",
           default => $backup_target,
        },
        default => "$drupal_backup_target",
    }
  
    # Frequency of backups
    $backup_frequency = $drupal_backup_frequency ? {
        ''      => "daily",
        default => "$drupal_backup_frequency",
    }

    # If drupal data have to be backed up
    $backup_data_enable = $drupal_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        },
        default => $drupal_backup_data,
    }

    # If drupal logs have to be backed up
    $backup_log_enable = $drupal_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        },
        default => $drupal_backup_log,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) drupal::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $drupal_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$drupal_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $drupal_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$drupal_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $drupal_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $drupal_firewall_enable,
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
