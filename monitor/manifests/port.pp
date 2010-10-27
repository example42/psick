define monitor::port (
    $port,
    $protocol,
    $target,
    $tool,
    $enable='true'
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) {
            file { "${puppet::params::debugdir}/todo/monitor-port-munin_$name":
                ensure => present,
                content => "Name: $name \nPort: $port \nProtocol: $protocol \nTarget: $target \nTool: $tool \nEnable: $enable\n"
            }
        }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) {
            file { "${puppet::params::debugdir}/todo/monitor-port-collectd_$name":
                ensure => present,
                content => "Name: $name \nPort: $port \nProtocol: $protocol \nTarget: $target \nTool: $tool \nEnable: $enable\n"
            }
        }
    }

    if ($tool =~ /monit/) {
        if ( $debug == "yes" ) or ( $debug == true ) {
            file { "${puppet::params::debugdir}/todo/monitor-port-monit_$name":
                ensure => present,
                content => "Name: $name \nPort: $port \nProtocol: $protocol \nTarget: $target \nTool: $tool \nEnable: $enable\n"
            }
            file { "${puppet::params::debugdir}/todo/monitor-port-monit-$port-$protocol": ensure => absent } # TODO Remove after cleanup
        }
    }

    if ($tool =~ /nagios/) {
        monitor::port::nagios { "$name":
            target   => $target,
            protocol => $protocol,
            port     => $port,
            enable   => $enable,
        }
    }

}

