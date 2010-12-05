#
# Class rsyslog::server::mysql 
# 
# Manages Mysql on Rsyslog server 
# Autoloaded if $rsyslog_db = mysql 
#
class rsyslog::server::mysql {
    require rsyslog::params

    package { "rsyslog-mysql":
        ensure => present,
    }

    file { "rsyslog.mysql":
        path    => "${rsyslog::params::configdir}/mysql.conf",
        mode    => "${rsyslog::params::configfile_mode}",
        owner   => "${rsyslog::params::configfile_owner}",
        group   => "${rsyslog::params::configfile_group}",
        ensure  => present,
        require => Package["rsyslog"],
        notify  => Service["rsyslog"],
        content => template("rsyslog/rsyslog.mysql.erb"),
    }


    case $rsyslog::params::db_server {
        "localhost","127.0.0.1": {
            include mysql
            mysql::grant { "rsyslog_server_grants_${fqdn}":
                mysql_db         => "${rsyslog::params::db_name}",
                mysql_user       => "${rsyslog::params::db_user}",
                mysql_password   => "${rsyslog::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host       => "${rsyslog::params::db_server}",
                notify           => Service["rsyslog"],
            }
        }
        default: {
            # Attempt to automanage Mysql grants on external servers. TODO: Verify if it works ;-D
            @@mysql::grant { "rsyslog_server_grants_${fqdn}":
                mysql_db         => "${rsyslog::params::db_name}",
                mysql_user       => "${rsyslog::params::db_user}",
                mysql_password   => "${rsyslog::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host       => "${fqdn}",
                tag              => "mysql_grants_${rsyslog::params::db_server}",
            }
        }
    }

}
