#
# Define monitor::mount::nagios
#
# Nagios connector for monitor::mount abstraction layer
# It's automatically used if "nagios" is present in the $monitor_tool array
# By default it uses Example42 nagios module, it can be adapted for third party modules
#
define monitor::mount::nagios (
    $name,
    $fstype,
    $enable
    ) {

    $ensure = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "present",
        "true"  => "present",
        "yes"   => "present",
    }

    $escapedname=regsubst($name,'/','_','G')

    # Use for Example42 nagios/nrpe modules
    nagios::service { "Mount_$escapedname":
        ensure      => $ensure,
        check_command => "check_nrpe!check_mount!${name}!${fstype}",
    }

}
