class repo::modpassenger {
    file {
             "/etc/yum.repos.d/modpassenger.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/modpassenger.repo",
    }
}

