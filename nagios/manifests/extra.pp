#
# Class: nagios::extra
#
# Some extra stuff necessary for Example42 Nagios implementation
# Needed to make things go smoothly 
#
# Usage:
# Autoincluded by nagios class
#
class nagios::extra {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params

    file { "nagios_configdir":
        path    => "${nagios::params::customconfigdir}",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => Package["nagios"],
    }

    file { "nagios_configdir_hosts":
        path    => "${nagios::params::customconfigdir}/hosts",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => File["nagios_configdir"],
        recurse => true, purge => true, force => true,
    }

    file { "nagios_configdir_services":
        path    => "${nagios::params::customconfigdir}/services",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => File["nagios_configdir"],
        recurse => true, purge => true, force => true,
    }

    file { "nagios_configdir_commands":
        path    => "${nagios::params::customconfigdir}/commands",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => File["nagios_configdir"],
    }

    file { "nagios_configdir_hostgroups":
        path    => "${nagios::params::customconfigdir}/hostgroups",
        mode    => "755",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => directory,
        require => File["nagios_configdir"],
    }


    # General Nagios configuration files
    # Customize and adapt ! 

    file { "nagios_commands_general.cfg":
        path    => "${nagios::params::customconfigdir}/commands/general.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        source  => "${nagios::params::general_base_source}/nagios/commands.cfg",
        require => File["nagios_configdir"],
    }

    file { "nagios_commands_extra.cfg":
        path    => "${nagios::params::customconfigdir}/commands/extra.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        content => template("nagios/commands-extra.cfg.erb"),
        require => File["nagios_configdir"],
    }

    file { "nagios_contacts.cfg":
        path    => "${nagios::params::customconfigdir}/contacts.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        source  => "${nagios::params::general_base_source}/nagios/contacts.cfg",
        require => File["nagios_configdir"],
    }

    file { "nagios_timeperiods.cfg":
        path    => "${nagios::params::customconfigdir}/timeperiods.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        source  => "${nagios::params::general_base_source}/nagios/timeperiods.cfg",
        require => File["nagios_configdir"],
    }

    file { "nagios_templates.cfg":
        path    => "${nagios::params::customconfigdir}/templates.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        source  => "${nagios::params::general_base_source}/nagios/templates.cfg",
        require => File["nagios_configdir"],
    }

    file { "nagios_hostgroup_all.cfg":
        path    => "${nagios::params::customconfigdir}/hostgroups/all.cfg",
        mode    => "644",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        source  => "${nagios::params::general_base_source}/nagios/hostgroup_all.cfg",
        require => File["nagios_configdir"],
    }

}
