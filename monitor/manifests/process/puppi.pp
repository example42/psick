#
# Define monitor::process::puppi
#
# Connector for Nagios plugins based local checks for monitor::process abstraction layer
# It's automatically used if "puppi" is present in the $monitor_tool array
# Local checks based on Nagios plugins are included in Example42 puppi module
#
define monitor::process::puppi (
    $pidfile,
    $process,
    $argument,
    $service,
    $enable
    ) {

    # Use for Example42 puppi checks
    puppi::check { "$name":
        enable   => $enable,
        hostwide => "yes",
        command  => $process ? {
            undef   => "check_procs -c 1: -C ${name}" ,
            default => $argument ? {
                undef   => "check_procs -c 1: -C ${process}" ,
                ""      => "check_procs -c 1: -C ${process}" ,
                default => "check_procs -c 1: -C ${process} -a ${argument}" ,
            }
        }
    }

}
