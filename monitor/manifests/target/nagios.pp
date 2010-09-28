# Monitor::target connector.
# To be used on hosts monitored by nagios, alternative to monitor::host

class monitor::target::nagios {

    # Use for Immerda and DavidS nagios module
    # include nagios_target

    # Use for RiseUp nagios module
    include nagios::target
    # Or alternatives like:
    # include nagios::target::fqdn
    # include nagios::target::nat

    # Use for Camptocamp nagios module
    # nagios::host::local  { "$fqdn": ensure => present, address =>$ipaddress, }

}

