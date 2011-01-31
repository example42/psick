define monitor::url (
    $url="http://127.0.0.1",
    $target="",
    $port='80',
    $pattern="",
    $username="",
    $password="",
    $monitorgroup="",
    $tool,
    $checksource='remote',
    $enable=true
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }


# Temp workaround
# $computed_target = "$fqdn" # WORKS :-I
# $computed_target = urlhostname("http://127.0.0.1") # WORKS
# $computed_target = urlhostname("$url")

    # If target is not provided we get it from the Url
    $computed_target = $target ? {
        ''      => urlhostname("$url"),
        default => "${target}",
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
#            target       => $computed_target,
#            port         => $port,
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
            target       => $computed_target,
            port         => $port,
            pattern      => $pattern,
            username     => $username,
            password     => $password,
            monitorgroup => $monitorgroup,
            checksource  => $checksource,
            enable       => $enable,
        }
    }

    if ($tool =~ /puppi/) {
        monitor::url::puppi { "$name":
            url          => $url,
            target       => $computed_target,
            port         => $port,
            pattern      => $pattern,
            username     => $username,
            password     => $password,
            monitorgroup => $monitorgroup,
            checksource  => $checksource,
            enable       => $enable,
        }
    }

}

