# Define puppi::info
#
# This define creates a file containing a set of commands to show information about custom topics
# to be used by the puppi info command.
#
# Note: A quick and dirty fix to manage an array of commands to use for the "run" argument
#       requires the usage of "###" to separate each command
#
# Usage:
# puppi::log { "network":
#     description => "Network status and information" ,
#     run    => "ifconfig ### route -n",
# }
#
define puppi::info (
    $description="",
    $run ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    file { "${puppi::params::infodir}/${name}":
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => Class["puppi"],
        content => template("puppi/info.erb"),
        tag     => 'puppi_info',
    }
}
