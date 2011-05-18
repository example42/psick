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
        munin::plugin { "$name": }
    }

    if ($tool =~ /collectd/) {
        collectd::plugin { "$name": }
    }

    if ($tool =~ /monit/) {
    }

    if ($tool =~ /nagios/) {
    }

} # End if $enable

}

