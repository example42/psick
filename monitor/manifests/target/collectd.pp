# Monitor::target connector.
# To be used on hosts monitored by collectd
# Can be adapted to use different, alternative, collectd modules

class monitor::target::collectd {
    # Use for Example42 collectd module
    include collectd
    collectd::plugin { "general": }
    collectd::plugin { "network": collectd_server => "$collectd_server" , }
}

