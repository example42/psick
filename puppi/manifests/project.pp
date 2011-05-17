# Define puppi::project
#
# This define creates and configures a Puppi project
# You must use different puppi::deploy defines to build up the commands list
#
define puppi::project (
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "directory",
        "true"  => "directory",
        "yes"   => "directory",
    }

    $ensurefile = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "present",
        "true"  => "present",
        "yes"   => "present",
    }

    # Create Project subdirs
    file {
        "${puppi::params::projectsdir}/${name}":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        ensure => "${ensure}", require => Class["puppi"] , force => true;
        "${puppi::params::projectsdir}/${name}/check":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        recurse => true, purge => true, force => true,
        ensure => "${ensure}", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/rollback":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        recurse => true, purge => true, force => true,
        ensure => "${ensure}", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/deploy":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        recurse => true, purge => true, force => true,
        ensure => "${ensure}", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/initialize":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        recurse => true, purge => true, force => true,
        ensure => "${ensure}", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/report":
        mode => "755", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        recurse => true, purge => true, force => true,
        ensure => "${ensure}", require => File["${puppi::params::projectsdir}/${name}"];
    }

    # Create Project configuration file
    file {
        "${puppi::params::projectsdir}/${name}/config":
        mode => "644", owner => "${puppi::params::configfile_owner}", group => "${puppi::params::configfile_group}",
        ensure => "${ensurefile}", require => File["${puppi::params::projectsdir}/${name}"] , 
        content => template("puppi/project/config.erb"),
    }

}
