# Define puppi::project
#
# This define creates and configures a Puppi project
# You must use different puppi::deploy defines to build up the commands list
#
define puppi::project (
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    # Create Project subdirs
    file {
        "${puppi::params::projectsdir}/${name}":
        mode => "755", owner => "${nrpe::params::configfile_owner}", group => "${nrpe::params::configfile_group}",
        ensure => "directory", require => Class["puppi"];
        "${puppi::params::projectsdir}/${name}/check":
        mode => "755", owner => "${nrpe::params::configfile_owner}", group => "${nrpe::params::configfile_group}",
        recurse => true, purge   => true,
        ensure => "directory", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/rollback":
        mode => "755", owner => "${nrpe::params::configfile_owner}", group => "${nrpe::params::configfile_group}",
        recurse => true, purge   => true,
        ensure => "directory", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/deploy":
        mode => "755", owner => "${nrpe::params::configfile_owner}", group => "${nrpe::params::configfile_group}",
        recurse => true, purge   => true,
        ensure => "directory", require => File["${puppi::params::projectsdir}/${name}"];
        "${puppi::params::projectsdir}/${name}/report":
        mode => "755", owner => "${nrpe::params::configfile_owner}", group => "${nrpe::params::configfile_group}",
        recurse => true, purge   => true,
        ensure => "directory", require => File["${puppi::params::projectsdir}/${name}"];
    }

}
