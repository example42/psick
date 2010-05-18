define monitor::host (
    $proto='',
    $address='',
    $host='',
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
        monitor::host::munin { "$name":
            address => $address,
        }
    }

    if $monitor_collectd == "yes" {
        monitor::host::collectd { "$name":
            address => $address,
        }
    }

    if $monitor_nagios == "yes" {
        monitor::host::nagios { "$fqdn":
            address => $address,
        }
    }

} # End if $enable

}

