# Define puppi::info
#
# This define creates a basic info file that simply contains a set of commands that show
# infos about custom topics. To be used by the puppi info command.
# By defult it builds the info script based on the minimal puppi/info.erb template but
# you can choose a custom template.
# Other info defines are used to gather and create puppi info scripts with different arguments
# and contents. Check puppi/manifests/info/ for alternative puppi::info::  plugins
#
# Usage:
# puppi::info { "network":
#     description => "Network status and information" ,
#     run    => [ "ifconfig" , "route -n" ],
# }
#
define puppi::info (
    $description="",
    $templatefile="puppi/info.erb",
    $run ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    file { "${puppi::params::infodir}/${name}":
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => Class["puppi"],
        content => template("$templatefile"),
        tag     => 'puppi_info',
    }
}
