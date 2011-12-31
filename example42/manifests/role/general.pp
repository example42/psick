class example42::role::general {

    Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

    include hosts
    include users
    include rsyslog
    include openssh
    include logrotate
    include cron
    include sysctl
    include timezone
    include ntp

    include rootmail
    include postfix

#    include snmpd
#    include monit
    include munin
    include nrpe

#    include mcollective
#    include func
#    include aide
#    include psad
#    include rsync

}
