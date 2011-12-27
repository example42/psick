# Class: autofs::params
#
# Defines autofs parameters
# In this class are defined as variables values that are used in other autofs classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class autofs::params  {

# Define if you want to use automount (If $users_auth=ldap)
    $mountdir = $autofs_mountdir ? {
        ''      => "/ldap",
        default => $autofs_mountdir,
    }

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "autofs",
    }

    $servicename = $operatingsystem ? {
        default => "autofs",
    }

    $processname = $operatingsystem ? {
        default => "automount",
    }

    $pidfile = $operatingsystem ? {
        default => "/var/run/autofs.fifo-net",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/auto.master",
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


    # If autofs process monitoring is enabled 
    $monitor_process_enable = $autofs_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $autofs_monitor_process,
    }

## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
 
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': { $general_base_source="puppet://$servername" }
        default: { $general_base_source=$base_source }
    }

    $autofs_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/autofs",
        /(^0.)/   => "$general_base_source/autofs",
        default   => "$general_base_source/modules/autofs",
    }

}
