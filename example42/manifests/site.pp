# Sample custom define to manage web sites:
# - Creates apache virtual host configuration
# - Creates document root directory
# - Creates puppi procedures for deploy of www files and eventually mysql data
# - Creates cron jobs for backup or www files and eventually mysql data
#
# Consider this as a reference on how to integrate puppi deploy procedures
# (and backup scripts) to a webapp define
#
define example42::site (
    $mysql_user="root",
    $mysql_host="localhost",
    $mysql_database="",
    $mysql_password="",
    $backup_origin="",
    $vhost_template="example42/apache/default.erb",
    $vhost_priority="20",
    $vhost_alias="" ) {

    include apache
    include apache::params

    apache::vhost { "${name}":
        port          => "80" ,
        docroot       => "${apache::params::documentroot}/${name}" ,
        serveraliases => $vhost_alias ,
        template      => $vhost_template ,
        priority      => $vhost_priority ,
    }

    file { "docroot_${name}":
        path   => "${apache::params::documentroot}/${name}/",
        ensure => directory,
    }

    puppi::project::builder { "${name}":
        source           => "rsync://deploy.${domain}/deploy/${name}/htdocs/",
        init_source      => "rsync://deploy.${domain}/init/${name}/htdocs/",
        source_type      => "dir",
        user             => "root",
        deploy_root      => "${apache::params::documentroot}/${name}/",
        report_email     => "root@example42.com",
        enable           => "true",
    }

  if ($mysql_database != "") {
    puppi::project::mysql { "${name}_sql":
        source           => "rsync://deploy.${domain}/deploy/${name}/sql/${mysql_database}.sql",
        init_source      => "rsync://deploy.${domain}/init/${name}/sql/${mysql_database}.sql",
        mysql_user       => "$mysql_user",
        mysql_host       => "$mysql_host",
        mysql_database   => "$mysql_database",
        mysql_password   => "$mysql_password",
        report_email     => "root@example42.com",
        enable           => "true",
    }
  }

    puppi::log { "$name":
        log => [ "/var/log/httpd/${name}-error_log" , "/var/log/httpd/${name}-access_log" ],
    }

  # Manages backups
  if ($backup_origin == "yes") {
    file { "/data/init/${name}":
        ensure => directory,
        tag    => "backup_origin",
    }
    file { "/data/deploy/${name}":
        ensure => directory,
        tag    => "backup_origin",
    }
    file { "/data/init/${name}/htdocs":
        ensure => directory,
        require => File["/data/init/${name}"],
        tag    => "backup_origin",
    }
    file { "/data/deploy/${name}/htdocs":
        ensure => directory,
        require => File["/data/deploy/${name}"],
        tag    => "backup_origin",
    }
    file { "/data/init/${name}/sql":
        ensure => directory,
        require => File["/data/init/${name}"],
        tag    => "backup_origin",
    }   
    file { "/data/deploy/${name}/sql":
        ensure => directory,
        require => File["/data/deploy/${name}"],
        tag    => "backup_origin",
    }
    file { "/etc/cron.daily/backup_${name}":
        mode    => "755",
        owner   => "root",
        group   => "root",
        content => template('example42/apache/backup.erb'),
        tag    => "backup_origin",
    }

    if ($mysql_database != "") {
        file { "/etc/cron.daily/backupsql_${name}":
            mode    => "750",
            owner   => "root",
            group   => "root",
            content => template('example42/apache/backupsql.erb'),
            tag    => "backup_origin",
        }
    }

  }

}
