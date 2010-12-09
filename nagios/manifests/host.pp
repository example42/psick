# Define nagios::host
#
# Use this to define Nagios host objects
# This is an exported resource.
# It should be included on the nodes to be monitored but has effects on the Nagios server
#
# Usage:
# nagios::host { "$fqdn": }
#
define nagios::host (
    $ip = $fqdn,
    $short_alias = $fqdn,
    $use = 'generic-host',
    $nagios_parent = '',
    $ensure = 'present',
    $hostgroups = 'all' ) {

    require nagios::params

    @@file { "${nagios::params::customconfigdir}/hosts/${name}.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/host.erb" ),
        tag     => "${nagios::params::grouptag}" ? {
            ''       => "nagios_host",
            default  => "nagios_host_$nagios::params::grouptag",
        },
    }

}
