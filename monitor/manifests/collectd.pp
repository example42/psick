# Monitor::collectd collector
# This is the collectd general collector
# Different alternatives are provided (and can be adapted) for different versions of the collectd module
# Here are examples from DavidS, Immerda, Captocamp, RiseUp and others' collectd module version

define monitor::host::collectd (
    ) {     
    # Use for Example42 collectd module (and others)
    include collectd
    collectd::plugin { "general": }
    collectd::plugin { "network": collectd_server => "$collectd_server" , }    
}

define monitor::plugin::collectd (
    ) {     
    # Use for Example42 collectd module (and others)
    collectd::plugin { "$name": }
}


# Monitor::server connector.
# To be used on collectd central server
# Can be adapted to use different, alternative, collectd modules

class monitor::server::collectd {
    # Use for Example42 collectd module
    include collectd::collection
}


# Monitor::target connector.
# To be used on hosts monitored by collectd
# Can be adapted to use different, alternative, collectd modules

class monitor::target::collectd {
    # Use for Example42 collectd module
    include collectd
    collectd::plugin { "general": }
    collectd::plugin { "network": collectd_server => "$collectd_server" , }
}
