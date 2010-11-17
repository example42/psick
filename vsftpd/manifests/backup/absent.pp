# Class: vsftpd::backup::absent
#
# Remove vsftpd backup elements
#
class vsftpd::backup::absent {

    include vsftpd::params

    backup { "vsftpd_data": 
        frequency => "${vsftpd::params::backup_frequency}",
        path      => "${vsftpd::params::datadir}",
        enabled   => "false",
        target    => "${vsftpd::params::backup_target_real}",
    }
    
    backup { "vsftpd_logs": 
        frequency => "${vsftpd::params::backup_frequency}",
        path      => "${vsftpd::params::logdir}",
        enabled   => "false",
        target    => "${vsftpd::params::backup_target_real}",
    }

}
