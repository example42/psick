# Class: nfs::params
#
# Defines nfs parameters
# In this class are defined as variables values that are used in other nfs classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class nfs::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        ubuntu => "nfs-common",
        debian => "nfs-common",
        redhat => "nfs-utils",
        centos => "nfs-utils",
    }

    $servicename = $operatingsystem ? {
        ubuntu => "nfs-kernel-server",
        debian => "nfs-kernel-server",
        default => "nfs",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/exports",
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

    $nfs_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/nfs",
        /(^0.)/   => "$general_base_source/nfs",
        default   => "$general_base_source/modules/nfs",
    }

}
