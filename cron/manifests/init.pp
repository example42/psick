class cron {

    case $::osfamily {
        'Redhat': {
            include cron::base
            include cron::crontabs
        }
        'Debian': {
            include cron::base
        }
        freebsd: { }
    }

    # Monitoring?
    if $monitor == "yes" { include cron::monitor }

}