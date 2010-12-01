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
    $checksource,
    $enable
    ) {

    # Use for Example42 puppi checks
    puppi::check { "$name":
        enable   => $enable,
        hostwide => "yes",
        command  => $protocol ? {
            tcp => $checksource ? {
                local   => "check_tcp -H localhost -p ${port}" ,
                default => "check_tcp -H ${target} -p ${port}" ,
            },
            udp => $checksource ? {
                local   => "check_udp -H localhost -p ${port}" ,
                default => "check_udp -H ${target} -p ${port}" ,
            },
        }
    }

}


