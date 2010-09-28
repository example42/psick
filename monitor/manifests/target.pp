class monitor::target {
    if $monitor_munin == "yes"    { include monitor::target::munin }
    if $monitor_collectd == "yes" { include monitor::target::collectd }
    if $monitor_nagios == "yes"   { include monitor::target::nagios }
}

