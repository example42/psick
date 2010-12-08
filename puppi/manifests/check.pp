# Define puppi::check
#
# This define creates a file with a check command that can be used locally.
# It ususes Nagios plugins for all checks
# It creates a file with the relevant check that can be used by automatic checking scripts
#
# Usage:
# puppi::check { "checkname":
#     command => "check_tcp -H localhost -p 80"
# }
#
define puppi::check (
    $command,
    $hostwide="no",
    $priority="50",
    $project="default",
    $enable = "true" ) {

    require puppi::params
    require nrpe::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

case $hostwide {
    no: {
        file { "${puppi::params::projectsdir}/$project/check/${priority}-${name}":
            mode    => "755",
            owner   => "${nrpe::params::configfile_owner}",
            group   => "${nrpe::params::configfile_group}",
            ensure  => "${ensure}",
            require => Class["puppi"],
            content => "${nrpe::params::pluginsdir}/${command}\n",
            tag     => 'puppi_check',
        }
    }
    default: {
        file { "${puppi::params::checksdir}/${priority}-${name}":
            mode    => "755",
            owner   => "${nrpe::params::configfile_owner}",
            group   => "${nrpe::params::configfile_group}",
            ensure  => "${ensure}",
            require => Class["puppi"],
            content => "${nrpe::params::pluginsdir}/${command}\n",
            tag     => 'puppi_check',
        }
    }
}

}
