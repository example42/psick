define monitor::service (
    $servicename='',
    $processlimit='',
    $service='',
    $enable=''
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if $monitor_munin == "yes" {
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
    }

} # End if $enable

}

