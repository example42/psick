#
# Define monitor::process::nagios
#
# Nagios connector for monitor::process abstraction layer
# It's automatically used if "nagios" is present in the $monitor_tool array
# By default it uses Example42 nagios module, it can be adapted for third party modules
#
define monitor::process::nagios (
    $pidfile,
    $process,
    $service,
    $enable
    ) {

    $ensure = $enable ? {
        "false"   => "absent",
        "true"    => "present",
    }

    # Use for Example42 service checks via nrpe 
    nagios::service { "$name":
        ensure      => $ensure,
        check_command => $process ? {
            undef    => "check_nrpe!check_process!${name}" ,
            default => "check_nrpe!check_process!${process}" ,
        }
    }

}
