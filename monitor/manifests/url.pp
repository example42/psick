define monitor::url (
    $url='',
    $pattern='',
    $username='',
    $password='',
    $enable=''
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

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

