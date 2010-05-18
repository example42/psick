# Experimental monitor abstraction module.
# This can be used to monitor hosts and applications with different methods.
#
#

import "*.pp"
import "defines/*.pp"
# import "classes/*.pp"


class monitor::server {
    if $monitor_munin == "yes"    { include monitor::server::munin }
    if $monitor_collectd == "yes" { include monitor::server::collectd }
    if $monitor_nagios == "yes"   { include monitor::server::nagios }
}


class monitor::target {
    if $monitor_munin == "yes"    { include monitor::target::munin }
    if $monitor_collectd == "yes" { include monitor::target::collectd }
    if $monitor_nagios == "yes"   { include monitor::target::nagios }
}
