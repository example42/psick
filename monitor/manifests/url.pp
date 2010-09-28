define monitor::url (
    $url='',
    $username='',
    $password='',
    $enable=''
    ) {

if $enable != "false" {

    if $monitor_munin == "yes" {
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
        monitor::url::nagios { "$name":
            url    => $url,
        }
    }

} # End if $enable

}

