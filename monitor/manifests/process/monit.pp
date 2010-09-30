define monitor::process::monit (
    $pidfile='',
    $process='',
    $service=''
    ) {

    # Use for Example42 monit module
    monit::checkpid { "${process}":
        pidfile      => "${pidfile}",
        startprogram => "/etc/init.d/${service} start",
        stopprogram  => "/etc/init.d/${service} stop",
    }

}

