# Class: controltier::params
#
# Defines controltier parameters
# In this class are defined as variables values that are used in other controltier classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class controltier::params  {

# Define controltier server 
    $server = $controltier_server ? {
        ''      => "ctl.example42.com",
        default => $controltier_server,
    }

# Control tier user (on clients). Default "ctier" aligned to official RPMs. Change only if you know what you do. 
    $user = $controltier_user ? {
        ''      => "ctier",
        default => $controltier_user,
    }

# Control tier root dir (on clients). Default "/opt/ctier" aligned to official RPMs. Change only if you know what you do. 
    $root = $controltier_root ? {
        ''      => "/opt/ctier",
        default => $controltier_root,
    }

## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "ctier-client",
    }

    $packagename_server = $operatingsystem ? {
        default => "ctier-server",
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

    $controltier_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/controltier",
        /(^0.)/   => "$general_base_source/controltier",
        default   => "$general_base_source/modules/controltier",
    }

}
