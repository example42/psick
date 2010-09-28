# Monitor::server connector.
# To be used on nagios central server
# Can be adapted to use different, alternative, nagios modules

class monitor::server::nagios {

    # Use for Immerda and DavidS nagios module
    # include nagios

    # Use for RiseUp nagios module
    include nagios::apache
    include nagios::defaults

    # Use for Camptocamp nagios module
    # include nagios::base
    # include nagios::nsca::daemon
    # include nagios::webinterface

}

