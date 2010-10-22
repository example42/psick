# Define nagios::command
#
# Use this to define Nagios command objects
# This is an exported resource.
# It should be included on the nodes to be monitored but has effects on the Nagios server
#
# Usage:
# nagios::command { "$fqdn": }
#
define nagios::command ( $command_line  = '' ) {

    require nagios::params

    file { "${nagios::params::configdir}/commands/${name}.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/command.erb" ),
    }

}
