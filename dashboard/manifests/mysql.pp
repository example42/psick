class dashboard::mysql {
    require dashboard::params

    case $dashboard::params::db_server {
        "localhost","127.0.0.1": {
            include mysql
            mysql::grant { "dashboard_server_grants_${fqdn}":
                mysql_db => "dashboard",
                mysql_user => "${dashboard::params::db_user}",
                mysql_password => "${dashboard::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host => "${dashboard::params::db_server}",
                # notify => Service["dashboardmaster"],
            }
        }
        default: {
            # Attempt to automanage Mysql grants on external servers. TODO: Verify if it works ;-D
            @@mysql::grant { "dashboard_server_grants_${fqdn}":
                mysql_db => "dashboard",
                mysql_user => "${dashboard::params::db_user}",
                mysql_password => "${dashboard::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host => "${fqdn}",
                tag => "mysql_grants_${dashboard::params::db_server}",
            }
        }
    }

}
