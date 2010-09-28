define monitor::host::collectd (
    ) {     
    # Use for Example42 collectd module (and others)
    include collectd
    collectd::plugin { "general": }
    collectd::plugin { "network": collectd_server => "$collectd_server" , }    
}

