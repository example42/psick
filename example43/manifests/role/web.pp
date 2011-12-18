class example43::role::web {
    $role="web"
    include example43::role::general

    include mysql
    php::module { mysql: }
    php::module { gd: }
    php::module { xml: }

    example43::site { "openskills.info": backup_origin => $backup_origin , mysql_user => "root" , mysql_database => "openskills" , vhost_template => "example43/apache/openskills.erb" }
    example43::site { "www.example43.it": backup_origin => $backup_origin , vhost_template => "example43/apache/example43.erb" }
    example43::site { "www.example42.com": backup_origin => $backup_origin , mysql_user => "root" , mysql_database => "drupal" , vhost_template => "example43/apache/example42.erb" }
    example43::site { "abnormalia.net": backup_origin => $backup_origin , vhost_template => "example43/apache/abnormalia.erb" }
#     example43::site { "git.example42.com": backup_origin => $backup_origin , vhost_template => "example43/apache/git.example42.erb" }

    if $firewall == "yes" { iptables::rule { "quick_git": port => 9418 } }

    if $backup_origin == "yes" {
        file { "/data":
            ensure => directory,
            owner  => "root",
            group  => "root",
            mode   => "755",
        }
        file { "/data/deploy":
            ensure => directory,
            owner  => "root",
            group  => "root",
            mode   => "750",
            require => File["/data"] ,
        }
        file { "/data/init":
            ensure => directory,
            owner  => "root",
            group  => "root",
            mode   => "750",
            require => File["/data"] ,
        }

        File <<| tag == "backup_origin" |>>
    }
}
