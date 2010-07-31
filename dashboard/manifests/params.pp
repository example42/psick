# Class: dashboard::params
#
# Defines dashboard parameters
# In this class are defined as variables values that are used in other dashboard classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class dashboard::params  {

# Sets installation method according to user's variable dashboard_install (if not set, default is package)

    $install = $dashboard_install ? {
        source  => "source",
        package => "package",
        default => "package",
    }

# Different syntax same result (left for reference)
#    case $dashboard_install {
#        source: { $install="source" }
#        package: { $install="package" }
#        '': { $install="package" }
#    }

    $basedir = "/usr/share"

    $use_mysql = "yes"

# Sets externalnodes support according to user's variable puppet_externalnodes (if not set, default is no)
    $externalnodes = $puppet_externalnodes ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }



# Basic settings
    $packagename = $operatingsystem ? {
        default => "puppet-dashboard",
    }

    $servicename = $operatingsystem ? {
        default => "puppet-dashboard",
    }

    $configfile = $operatingsystem ? {
        default => "$basedir/puppet-dashboard/config/database.yml",
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

# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': { $general_base_source="puppet://$servername" }
        default: { $general_base_source=$base_source }
    }

    $dashboard_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/dashboard",
        /(^0.)/   => "$general_base_source/dashboard",
        default   => "$general_base_source/modules/dashboard",
    }

}
