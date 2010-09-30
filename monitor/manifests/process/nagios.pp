define monitor::process::nagios (
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

