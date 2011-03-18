#
# Define monitor::mount::puppi
#
# Connector for Nagios plugins based local checks for monitor::mount abstraction layer
# It's automatically used if "puppi" is present in the $monitor_tool array
# Local checks based on Nagios plugins are included in Example42 puppi module
#
define monitor::mount::puppi (
    $name,
    $fstype,
    $enable
    ) {

    $escapedname=regsubst($name,'/','_','G')

    # Use for Example42 puppi checks
    puppi::check { "Mount_$escapedname":
        enable   => $enable,
        hostwide => "yes",
        command  => "check_mount -m ${name} -t ${fstype}" ,
    }

}
