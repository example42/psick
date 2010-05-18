class aide {

    package { aide:
        name   => $operatingsystem ? {
            default    => "aide",
            },
        ensure => present,
    }

    file {    
             "aide.conf":
#            mode => 600, owner => root, group => root,
            require => Package["aide"],
            ensure => present,
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/aide.conf",
                debian  => "/etc/aide/aide.conf",
                ubuntu  => "/etc/aide/aide.conf",
                       default => "/etc/aide.conf",
            },
    }

# Cron job
#    file {    
#             "aide.sh":
#            mode => 750,
#            owner => root, group => root,
#            require => File["aide.conf"],
#            ensure => present,
#            path => $operatingsystem ?{
#                default => "/etc/cron.daily/aide",
#            },
#            source => "puppet://$server/aide/aide.sh",
#    }
    
}

