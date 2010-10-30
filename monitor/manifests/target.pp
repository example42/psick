class monitor::target {

    if ($monitor_tool =~ /munin/) { include monitor::target::munin }
    if ($monitor_tool =~ /collectd/) { include monitor::target::collectd }
    if ($monitor_tool =~ /nagios/) { include monitor::target::nagios }

}

