define monitor::port::nagios (
    $target='',
    $port='',
    $protocol=''
    ) {

    # Use for Immerda and DavidS nagios module
    nagios::service { "$name":
        ensure      => present,
        check_command => $protocol ? {
            tcp => "check_tcp!${port}",
            udp => "chekc_ucp!${port}",
            }
    }

    # Use for Camptocamp (You can choose alternatives for distributed environent)
    # nagios::service::distributed { "$name":
    #    ensure      => present,
    #    check_command => $protocol ? {
    #        tcp => "check_tcp!${port}",
    #        udp => "chekc_ucp!${port}",
    #        }
    # }

}


