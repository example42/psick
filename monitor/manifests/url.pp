define monitor::url (
    $url,
    $pattern="",
    $username="",
    $password="",
    $monitorgroup="",
    $tool,
    $enable=true
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    $urlq = regsubst($url , '/' , '-' , 'G') # Needed to create flag todo files seamlessly

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-munin-$urlq": ensure => present } }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-collect-$urlq": ensure => present } }
    }

    if ($tool =~ /monit/) {
#            monitor::url::monit { "$name":
#            url          => $url,
#            pattern      => $pattern,
#            username     => $username,
#            password     => $password,
#            monitorgroup => $monitorgroup,
#            enable       => $enable,
#        }
    }

    if ($tool =~ /nagios/) {
        monitor::url::nagios { "$name":
            url          => $url,
            pattern      => $pattern,
            username     => $username,
            password     => $password,
            monitorgroup => $monitorgroup,
            enable       => $enable,
        }
    }

    if ($tool =~ /puppi/) {
        monitor::url::puppi { "$name":
            url          => $url,
            pattern      => $pattern,
            username     => $username,
            password     => $password,
            monitorgroup => $monitorgroup,
            enable       => $enable,
        }
    }

}

