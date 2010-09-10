# Class: foreman::params
#
# Defines foreman parameters
# In this class are defined as variables values that are used in other foreman classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
#
class foreman::params  {

# Sets installation method according to user's variable foreman_install (if not set, default is choosed according to OS)

    $install = $foreman_install ? {
        source  => "source",
        package => "package",
        default => $operatingsystem ? { 
            debian => "package",
            ubuntu => "package",
            centos => "package",
            redhat => "package",
            default => "source",
        },
    }

    $basedir = "/usr/share"

# Settings for deb manual install
    $deb_url = "http://theforeman.org/attachments/download/109/foreman_0.1.5-1_all.deb"
    $workdir = "/var/tmp"
    $deb_filename = urlfilename($deb_url)


# Sets externalnodes support according to user's variable puppet_externalnodes (if not set, default is no)
    $externalnodes = $puppet_externalnodes ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }


# Define foreman DB type
    $db = $foreman_db ? {
        sqlite  => "sqlite",
        mysql   => "mysql",
        postgresql   => "postgresql",
        default => "sqlite",
    }

# Define foreman DB server ($foreman_db_server). Default: localhost
    $db_server = $foreman_db_server ? {
        ''      => "localhost",
        default => $foreman_db_server,
    }

# Define foreman DB user ($foreman_db_user). Default: root
    $db_user = $foreman_db_user ? {
        ''      => "root",
        default => $foreman_db_user,
    }

# Define foreman DB password ($foreman_db_password). Default: blank
    $db_password = $foreman_db_password ? {
        ''      => "",
        default => $foreman_db_password,
    }


# Basic settings
    $packagename = $operatingsystem ? {
        default => "foreman",
    }

    $servicename = $operatingsystem ? {
        default => "foreman",
    }

    $configfile = $operatingsystem ? {
        default => "$basedir/foreman/config/database.yml",
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

    $foreman_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/foreman",
        /(^0.)/   => "$general_base_source/foreman",
        default   => "$general_base_source/modules/foreman",
    }

}
