class monitor::server {
    if $monitor_munin == "yes"    { include monitor::server::munin }
    if $monitor_collectd == "yes" { include monitor::server::collectd }
    if $monitor_nagios == "yes"   { include monitor::server::nagios }
}
