class cron {

    case $operatingsystem {
        centos: {
            include cron::base
            include cron::crontabs
        }
        redhat: {
            include cron::base
            include cron::crontabs
        }

        debian: { include cron::base }
        ubuntu: { include cron::base }
        freebsd: { }
    }

    # Monitoring?
    if $monitor == "yes" { include cron::monitor }

}
