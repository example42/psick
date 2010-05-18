# Monitor::nagios connector
# Different alternatives are provided (and can be adapted) for different versions of the nagios module
# Here are examples from DavidS, Immerda, Captocamp, RiseUp and others' nagios module version
# To be checked and adapted.

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


define monitor::port::nagios (
    $address='',
    $port='',
    $proto=''
    ) {

    # Use for Immerda and DavidS nagios module
    nagios::service { "$name":
        ensure      => present,
        check_command => $proto ? {
            tcp => "check_tcp!${port}",
            udp => "chekc_ucp!${port}",
            }
    }

    # Use for Camptocamp (You can choose alternatives for distributed environent)
    # nagios::service::distributed { "$name":
    #    ensure      => present,
    #    check_command => $proto ? {
    #        tcp => "check_tcp!${port}",
    #        udp => "chekc_ucp!${port}",
    #        }
    # }

}


define monitor::process::nagios (
    $address='',
    $processname=''
    ) {

    # Use for Immerda and DavidS and derivated Nagios modules
    nagios::service { "$name":
        ensure      => present,
        check_command => $processname ? {
            undef    => "check_procs!${name}" ,
            default => "check_procs!${processname}" ,
        }
    }

    # Use for Camptocamp (You can choose alternatives for distributed environent)
    # nagios::service::distributed { "$name":
    # [...] 

}


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
