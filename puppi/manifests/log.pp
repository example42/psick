# Define puppi::log
#
# This define creates a basic log file that simply contains the list of logs to show
# when issuing the puppi log command.
#
# Usage:
# puppi::log { "system":
#     description => "General System Logs" ,
#     log    => [ "/var/log/syslog" , "/var/log/messages" ],
# }
#
define puppi::log (
    $description="",
    $log ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    file { "${puppi::params::logsdir}/${name}":
        mode    => "644",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => Class["puppi"],
        content => template("puppi/log.erb"),
        tag     => 'puppi_log',
    }
}
