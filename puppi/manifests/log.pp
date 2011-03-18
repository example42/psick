# Define puppi::log
#
# This define creates a file containing a log path to be used by the puppi log command.
#
# Usage:
# puppi::log { "messages":
#     path => "/var/log/messages"
# }
#
define puppi::log (
    $logpath,
    $hostwide="no",
    $priority="50",
    $project="default",
    $enable = "true" ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "present",
        "true"  => "present",
        "yes"   => "present",
    }

case $hostwide {
    no: {
        file { "${puppi::params::projectsdir}/$project/log/${priority}-${name}":
            mode    => "644",
            owner   => "${puppi::params::configfile_owner}",
            group   => "${puppi::params::configfile_group}",
            ensure  => "${ensure}",
            require => Class["puppi"],
            content => "${logpath}\n",
            tag     => 'puppi_log',
        }
    }
    default: {
        file { "${puppi::params::logsdir}/${priority}-${name}":
            mode    => "644",
            owner   => "${puppi::params::configfile_owner}",
            group   => "${puppi::params::configfile_group}",
            ensure  => "${ensure}",
            require => Class["puppi"],
            content => "${logpath}\n",
            tag     => 'puppi_log',
        }
    }
}

}
