define monitor::port (
    $port,
    $protocol,
    $target,
    $tool,
    $enable
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-port-munin-$port-$protocol": ensure => present } }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-port-collectd-$port-$protocol": ensure => present } }
    }

    if ($tool =~ /monit/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-port-monit-$port-$protocol": ensure => present } }
    }

    if ($tool =~ /nagios/) {
        monitor::port::nagios { "$name":
            target  => $target,
            protocol => $protocol,
            port     => $port,
        }
    }

} # End if $enable

}

