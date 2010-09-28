define monitor::plugin (
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
        monitor::plugin::munin { "$name":
        }
    }

    if $monitor_collectd == "yes" {
        monitor::plugin::collectd { "$name":
        }
    }

    if $monitor_nagios == "yes" {
    }

} # End if $enable

}

