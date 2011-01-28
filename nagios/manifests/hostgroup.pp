# Define nagios::hostgroup
#
# Use this to define Nagios hostgroup objects
# This is an exported resource.
# It should be included on the nodes to be monitored but has effects on the Nagios server
#
# Usage:
# nagios::hostgroup { "$fqdn": }
#
define nagios::hostgroup ( 
    $ensure = 'present' ,
    $members = '*' ) {

    require nagios::params

    @@file { "${nagios::params::customconfigdir}/hostgroups/${name}.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/hostgroup.erb" ),
        tag     => "${nagios::params::grouptag}" ? {
            ''       => "nagios_hostgroup",
            default  => "nagios_hostgroup_${nagios::params::grouptag}",
        },
    }

}
