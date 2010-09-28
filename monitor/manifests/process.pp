define monitor::process (
    $proto='',
    $address='',
    $process='',
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
        monitor::process::nagios { "$name":
            address => $address,
            processname => $processname,
        }
    }

} # End if $enable

}

