define monitor::url::monit (
    $url,
    $pattern=""
    ) {

    # Use for Example42 monit module # TODO Fix
    monit::checkurl { "${url}":
        url     => "${url}",
        content => "${pattern}",
        fqdn    => "${fqdn}",
    }

}

