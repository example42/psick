define monitor::plugin (
    $plugin,
    $tool,
    $enable
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug
    }

    if ($tool =~ /munin/) {
        monitor::plugin::munin { "$name": }
    }

    if ($tool =~ /collectd/) {
        monitor::plugin::collectd { "$name": }
    }

    if ($tool =~ /monit/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-plugin-monit-$plugin": ensure => present } }
    }

    if ($tool =~ /nagios/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-plugin-nagios-$plugin": ensure => present } }
    }

} # End if $enable

}

