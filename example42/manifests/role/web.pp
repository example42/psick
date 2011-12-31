class example42::role::web {
    $role="web"
    include example42::role::general

    include mysql
    php::module { mysql: }
    php::module { gd: }
    php::module { xml: }

    example42::site { "openskills.info": backup_origin => $backup_origin , mysql_user => "root" , mysql_database => "openskills" , vhost_template => "example42/apache/openskills.erb" }
    example42::site { "www.example42.it": backup_origin => $backup_origin , vhost_template => "example42/apache/example42.erb" }
    example42::site { "www.example42.com": backup_origin => $backup_origin , mysql_user => "root" , mysql_database => "drupal" , vhost_template => "example42/apache/example42.erb" }
    example42::site { "abnormalia.net": backup_origin => $backup_origin , vhost_template => "example42/apache/abnormalia.erb" }
#     example42::site { "git.example42.com": backup_origin => $backup_origin , vhost_template => "example42/apache/git.example42.erb" }

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
