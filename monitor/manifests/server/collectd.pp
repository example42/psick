# Monitor::server connector.
# To be used on collectd central server
# Can be adapted to use different, alternative, collectd modules

class monitor::server::collectd {
    # Use for Example42 collectd module
    include collectd::collection
}

