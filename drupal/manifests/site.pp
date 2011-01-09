# Define: drupal::site
#
# Setup a new Drupal site via drush
#
# Variables:
#
# Usage:
#

define drupal::site ( url ,
                      db_name="" ,
                      db_user ,
                      db_password ,
                      db_host="localhost" ,
                      db_type="mysql" ,
                      install_mode="no") {

    $true_install_mode = $install_mode ? {
        true   => "yes",
        "on"   => "yes",
        "true" => "yes",
        "yes"  => "yes",
        default => "no",
    }

    file { "${drupal::params::sitesdir}/$name":
        mode    => $true_install_mode ? {
            "no"  => "755" ,
            "yes" => "777" ,
            },
        owner   => "root",
        group   => "root",
        ensure  => directory,
        require => Class["drupal"],
    }

    case $db_host {
        "localhost","127.0.0.1": {
            include mysql
            mysql::grant { "drupal_grants_${name}":
                mysql_db         => "$db_name",
                mysql_user       => "$db_user",
                mysql_password   => "$db_password",
                mysql_privileges => "SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES",
                mysql_host       => "$db_host",
            }
        }
        default: {
            # Attempt to automanage Mysql grants on external servers. TODO: Verify if it works ;-D
            @@mysql::grant { "drupal_grants_${name}":
                mysql_db         => "$db_name",
                mysql_user       => "$db_user",
                mysql_password   => "$db_password",
                mysql_privileges => "SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES",
                mysql_host       => "${fqdn}",
                tag              => "drupal_grants_${db_host}",
            }
        }
    }


}

