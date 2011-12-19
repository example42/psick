# Class: jboss::params
#
# Sets internal variables and defaults for jboss module
# This class is loaded in all the classes that use the values set here 
#
class jboss::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET

    # Specify if installation is done via packages or downloading official zip
    $use_package  = $jboss_use_package ? {
        true    => "yes",
        "true"  => "yes",
        "yes"   => "yes",
        default => "no",
    }

    # Define which version to use 
    $version  = $jboss_version ? {
        '4'     => "4",
        '5'     => "5",
        '6'     => "6",
        '7'     => "7",
        default => "6",
    }

    # Where to get the source file (for $use_package = no). Set $jboss_source_url = "http://custom.url/" to override
    $source_url = $jboss_source_url ? {
        ''      => $jboss_version ? {
            '4'     => "http://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA.zip/download",
            '5'     => "http://sourceforge.net/projects/jboss/files/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip/download",
            # '6'     => "http://sourceforge.net/projects/jboss/files/JBoss/JBoss-6.0.0.Final/jboss-as-distribution-6.0.0.Final.zip/download",
            '6'     => "http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip",
            '7'     => "http://download.jboss.org/jbossas/7.0/jboss-as-7.0.1.Final/jboss-as-7.0.1.Final.zip", 
            default => "http://download.jboss.org/jbossas/6.1/jboss-as-distribution-6.1.0.Final.zip",
            },
        default => "${jboss_source_url}",
    }

    $destination_dir = $jboss_destination_dir ? {
        ''      => "/usr/local",
        default => "${jboss_destination_dir}",
    }

    $jboss_dir = $jboss_jboss_dir ? {
        ''      => "${destination_dir}/jboss",
        default => "${jboss_jboss_dir}",
    }
 
    $download_dir = $jboss_download_dir ? {
        ''      => "/var/tmp", # $jboss_download_dir must exist
        default => "${jboss_download_dir}",
    }

    $user = $jboss_user ? {
        ''      => "jboss",
        default => "${jboss_user}",
    }

    $group = $jboss_group ? {
        ''      => "jboss",
        default => "${jboss_group}",
    }

    $port = $jboss_port ? {
        ''      => "8080",
        default => "${jboss_port}",
    }

    # The urlfilename function is provided by Example 42 common module
    $source_filename = urlfilename($source_url) # Name of zip file
    $extracted_dir = regsubst($source_filename,'\.zip$','') # Name of basedir extracted from zip


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        debian  => "jboss",
        ubuntu  => "jboss",
        default => "jboss",
    }

    $servicename = $operatingsystem ? {
        debian  => "jboss",
        ubuntu  => "jboss",
        default => "jboss",
    }

    $processname = $operatingsystem ? {
        default => "java",
    }

    $hasstatus = $operatingsystem ? {
        default => false,
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/jboss",
        ubuntu  => "/etc/default/jboss",
        default => "/etc/sysconfig/jboss",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/jbossd.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/jboss",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/jboss",
    }

    # Used by monitor and firewall class
    $protocol = "tcp"


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) jboss::monitor class
# You can define these variables or leave the defaults
# The apparently complex variables assignements below follow this logic:
# - If no user variable is set, a reasonable default is used
# - If the user has set a host-wide variable (ex: $monitor_target ) that one is set
# - The host-wide variable can be overriden by a module specific one (ex: $jboss_monitor_target)

    # How the monitor server refers to the monitor target 
    $monitor_target_real = $jboss_monitor_target ? {
        ''      => $monitor_target ? {
           ''      => "${fqdn}",
           default => $monitor_target,
        },
        default => "$jboss_monitor_target",
    }

    # BaseUrl to access this service
    $monitor_baseurl_real = $jboss_monitor_baseurl ? {
        ''      => $monitor_baseurl ? {
           ''      => "http://${fqdn}",
           default => $monitor_baseurl,
        },
        default => "${jboss_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in jboss::monitor class
    $monitor_url_pattern = $jboss_monitor_url_pattern ? {
        ''      => "OK",
        default => "${jboss_monitor_url_pattern}",
    }

    # If jboss port monitoring is enabled 
    $monitor_port_enable = $jboss_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        },
        default => $jboss_monitor_port,
    }

    # If jboss url monitoring is enabled 
    $monitor_url_enable = $jboss_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => false,
           default => $monitor_url,
        },
        default => $jboss_monitor_url,
    }

    # If jboss process monitoring is enabled 
    $monitor_process_enable = $jboss_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $jboss_monitor_process,
    }

    # If jboss plugin monitoring is enabled 
    $monitor_plugin_enable = $jboss_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $jboss_monitor_plugin,
    }


## DEFAULTS FOR FIREWALL CLASS
# These are settings that influence the (optional) jboss::firewall class
# You can define these variables or leave the defaults

    # Source IPs that can access this service - Use iptables friendly format
    $firewall_source_real = $jboss_firewall_source ? {
        ''      => $firewall_source ? {
           ''      => "0.0.0.0/0",
           default => $firewall_source,
        },
        default => "$jboss_firewall_source",
    }

    # Destination IP to use for this host (Default facter's $ipaddress)
    $firewall_destination_real = $jboss_firewall_destination ? {
        ''      => $firewall_destination ? {
           ''      => "${ipaddress}",
           default => $firewall_destination,
        },
        default => "$jboss_firewall_destination",
    }

    # If firewall filter is enabled
    $firewall_enable = $jboss_firewall_enable ? {
        ''      => $firewall_enable ? {
           ''      => true,
           default => $firewall_enable,
        },
        default => $jboss_firewall_enable,
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
