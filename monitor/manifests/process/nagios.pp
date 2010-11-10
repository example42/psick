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
    $argument,
    $service,
    $enable
    ) {

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    # Use for Example42 service checks via nrpe 
    nagios::service { "$name":
        ensure      => $ensure,
        check_command => $process ? {
            undef   => "check_nrpe!check_process!${name}" ,
            default => $argument ? {
                undef   => "check_nrpe!check_process!${process}" ,
                ""      => "check_nrpe!check_process!${process}" ,
                default => "check_nrpe!check_processwitharg!${process}!${argument}" ,
            }
        }
    }

}
