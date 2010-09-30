define monitor::port (
    $protocol='',
    $target='',
    $port='',
    $enable=''
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if $monitor_munin == "yes" {
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
        monitor::port::nagios { "$name":
            target  => $target,
            protocol => $protocol,
            port     => $port,
        }
    }

} # End if $enable

}

