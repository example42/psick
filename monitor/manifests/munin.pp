# Monitor::munin connector
# Different alternatives are provided (and can be adapted) for different versions of the munin module
# Here are examples from DavidS, Immerda, Captocamp, RiseUp and others' munin module version

define monitor::host::munin (
    $address=''
    ) {

    # Use for DavidS, Immerda, RiseUp and PuppetManages munin module
    include munin::client

}


define monitor::plugin::munin (
    ) {

    # Use for Immerda and DavidS and derivated Nagios modules
    munin::plugin { "$name":
    }

}


# Monitor::server connector.
# To be used on munin central server
# Can be adapted to use different, alternative, munin modules

class monitor::server::munin {

    # Use for Immerda, DavidS and RiseUp munin module
    include munin::host
    
}


# Monitor::target connector.
# To be used on hosts monitored by munin
# Can be adapted to use different, alternative, munin modules

class monitor::target::munin {
    
    # Use for DavidS, Immerda and RiseUp munin module
    include munin::client

}
