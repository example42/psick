# Define nagios::service
#
# Use this to define Nagios service objects
# This is an exported resource.
# It should be included on the nodes to be monitored but has effects on the Nagios server
#
# Usage:
# nagios::service { "$fqdn": }
#
define nagios::service (
    $host_name = $fqdn,
    $check_command  = '',
    $service_description = '',
    $use = 'generic-service',
    $ensure = 'present' ) {

    require nagios::params

    # Autoinclude the target host class to pass Nagios internat checks (each service must have a defined host)
    include nagios::target

    # Set defaults based on the same define $name
    $real_check_command = $check_command ? {
        '' => $name,
        default => $check_command
    }

    $real_service_description = $service_description ? {
        '' => $name,
        default => $service_description
    }

    @@file { "${nagios::params::customconfigdir}/services/${host_name}-${name}.cfg":
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["nagios::extra"],
        notify  => Service["nagios"],
        content => template( "nagios/service.erb" ),
        tag     => "${nagios::params::grouptag}" ? {
            ''       => "nagios_service",
            default  => "nagios_service_$nagios::params::grouptag",
        },
    }

}
