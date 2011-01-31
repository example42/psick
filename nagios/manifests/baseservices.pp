# Define nagios::baseservices
#
# Use this to define Nagios basic service objects that will be applied to all nodes
# All local disks, memory, cpu, local users...
# It's automatically loaded in nagios::target
#
# This is an exported resource.
#
define nagios::baseservices (
    $host_name = $fqdn,
    $service_description = '',
    $use = 'generic-service',
    $ensure = 'present' ) {

    require nagios::params

    # For each target node we provide a service config file with basic checks (disks, memory, cpu).
    # Edit the template used to add checks you want on all nodes
    @@file { "${nagios::params::customconfigdir}/services/${host_name}-00-baseservices.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/baseservices.erb" ),
        tag     => "${nagios::params::grouptag}" ? {
            ''       => "nagios_service",
            default  => "nagios_service_$nagios::params::grouptag",
        },
    }

}
