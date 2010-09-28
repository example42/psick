define monitor::port (
    $proto='',
    $address='',
    $port='',
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
        monitor::port::nagios { "$name":
            address => $address,
            proto   => $proto,
            port    => $port,
        }
    }

} # End if $enable

}

