class monitor::server {

    if ($monitor_tool =~ /munin/) { include monitor::server::munin }
    if ($monitor_tool =~ /collectd/) { include monitor::server::collectd }
    if ($monitor_tool =~ /nagios/) { include monitor::server::nagios }

}

