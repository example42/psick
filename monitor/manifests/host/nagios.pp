define monitor::host::nagios (
    $address=''
    ) {

    # Use for Immerda and DavidS nagios module
    # include nagios_target

    # Use for RiseUp nagios module
    include nagios::target
    # Or alternatives like:
    # include nagios::target::fqdn
    # include nagios::target::nat

    # Use for Camptocamp nagios module
    # nagios::host::local  { "$fqdn": ensure => present, address =>$address, }

}

