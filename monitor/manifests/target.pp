class monitor::target {

    if ($monitor_tool =~ /munin/) { 
        # Use for DavidS, Immerda and RiseUp munin module
        include munin::client
    }

    if ($monitor_tool =~ /collectd/) { 
        # Use for Example42 collectd module
        include collectd
        collectd::plugin { "general": }
        collectd::plugin { "network": collectd_server => "$collectd_server" , }
    }

    if ($monitor_tool =~ /nagios/) { 
        # Use for Example42 nagios module
        include nagios::target

        # Use for Immerda and DavidS nagios module
        # include nagios_target

        # Use for RiseUp nagios module
        # include nagios::target
        # Or alternatives like:
        # include nagios::target::fqdn
        # include nagios::target::nat

        # Use for Camptocamp nagios module
        # nagios::host::local  { "$fqdn": ensure => present, address =>$ipaddress, }
    }

}


