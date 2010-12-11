class repo::mcollective {
    file {
            "/etc/yum.repos.d/mcollective.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/mcollective.repo",
    }
}

