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

# Different syntax same result
#    case $dashboard_install {
#        source: { $install="source" }
#        package: { $install="package" }
#        '': { $install="package" }
#    }

    $basedir = "/usr/share"

    $mysql = "yes"

# Sets externalnodes support according to user's variable dashboard_externalnodes (if not set, default is no)
    $externalnodes = $dashboard_externalnodes ? {
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

}
