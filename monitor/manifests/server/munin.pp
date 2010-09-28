# Monitor::server connector.
# To be used on munin central server
# Can be adapted to use different, alternative, munin modules

class monitor::server::munin {

    # Use for Immerda, DavidS and RiseUp munin module
    include munin::host
    
}
