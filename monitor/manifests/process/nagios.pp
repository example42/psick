define monitor::process::nagios (
    $pidfile='',
    $process='',
    $service=''
    ) {

    # Use for Example42 service checks via nrpe 
    nagios::service { "$name":
        ensure      => present,
        check_command => $process ? {
            undef    => "check_nrpe!check_process!${name}" ,
            default => "check_nrpe!check_process!${process}" ,
        }
    }

}
