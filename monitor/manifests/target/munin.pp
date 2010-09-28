# Monitor::target connector.
# To be used on hosts monitored by munin
# Can be adapted to use different, alternative, munin modules

class monitor::target::munin {
    
    # Use for DavidS, Immerda and RiseUp munin module
    include munin::client

}
