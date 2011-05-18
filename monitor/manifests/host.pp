define monitor::host (
    $proto='',
    $address='',
    $host='',
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
        include munin::client
    }

    if $monitor_collectd == "yes" {
        include collectd
        collectd::plugin { "general": }
        collectd::plugin { "network": collectd_server => "$collectd_server" , }    
    }

    if $monitor_nagios == "yes" {
        include nagios::target
    }

} # End if $enable

}

