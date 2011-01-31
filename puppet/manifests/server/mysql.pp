#
# Class puppet::server::mysql 
# 
# Manages Mysql on Puppet Master.
# Autoloaded if $puppet_db = mysql 
#
class puppet::server::mysql {
    require puppet::params

    case $puppet::params::db_server {
        "localhost","127.0.0.1": {
            include mysql
            mysql::grant { "puppet_server_grants_${fqdn}":
                mysql_db         => "puppet",
                mysql_user       => "${puppet::params::db_user}",
                mysql_password   => "${puppet::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host       => "${puppet::params::db_server}",
                # notify           => Service["puppetmaster"],
            }
        }
        default: {
            # Attempt to automanage Mysql grants on external servers. TODO: Verify if it works ;-D
            @@mysql::grant { "puppet_server_grants_${fqdn}":
                mysql_db         => "puppet",
                mysql_user       => "${puppet::params::db_user}",
                mysql_password   => "${puppet::params::db_password}",
                mysql_privileges => "ALL",
                mysql_host       => "${fqdn}",
                tag              => "mysql_grants_${puppet::params::db_server}",
            }
        }
    }

    case $operatingsystem {
        ubuntu,debian: {
            package {
                "libmysql-ruby":
                ensure => present;

            }
        }

        centos,redhat: {


        }
    }



}
