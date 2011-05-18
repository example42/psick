class monitor::server {

    if ($monitor_tool =~ /munin/) { 
        # Use for Immerda, DavidS and RiseUp munin module
        include munin::host
    }

    if ($monitor_tool =~ /collectd/) {
        # Use for Example42 collectd module
        include collectd::collection
    }

    if ($monitor_tool =~ /nagios/) { 
        # Use for Immerda and DavidS nagios module
        include nagios

        # Use for RiseUp nagios module
        # include nagios::apache
        # include nagios::defaults

        # Use for Camptocamp nagios module
        # include nagios::base
        # include nagios::nsca::daemon
        # include nagios::webinterface
    }

}

