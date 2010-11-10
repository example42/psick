#
# Define monitor::port::puppi
#
# Connector for Nagios plugins based local checks for monitor::port abstraction layer
# It's automatically used if "puppi" is present in the $monitor_tool array
# Local checks based on Nagios plugins are included in Example42 puppi module
#
define monitor::port::puppi (
    $target,
    $port,
    $protocol,
    $enable
    ) {

    # Use for Example42 puppi checks
    puppi::check { "$name":
        enable   => $enable,
        hostwide => "yes",
        command  => $protocol ? {
            tcp => "check_tcp -H ${target} -p ${port}" ,
            udp => "check_udp -H ${target} -p ${port}" ,
        }
    }

}


