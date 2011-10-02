# Class: pam::params
#
# Defines pam parameters
# In this class are defined as variables values that are used in other pam classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
# You don't have generally to modify this file.
#
class pam::params  {

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

# This variable is used to separate pam files according to OS layout
# It implies/supports:
# - Debian supported version is 5;
# - Ubuntu 8.04 LTS layout is the same of Debian 5
# - Ubuntu 10.04 LTS layout is pecific to Ubunut104
# - RedHat supported version is 5;
# - Centos follows obviously RedHat layout
    $oslayout = $operatingsystem ? {
        debian => "debian5",
        ubuntu => "ubuntu104",
        /(?i:CentOS|RedHat|Scientific)/ => "redhat5",
    }

# Basic settings
    $packagename = $operatingsystem ? {
        default => "pam",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/pam.d/",
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

    $pam_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/pam",
        /(^0.)/   => "$general_base_source/pam",
        default   => "$general_base_source/modules/pam",
    }

}
