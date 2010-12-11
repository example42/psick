class repo::puppetlabs {
    file {
             "/etc/yum.repos.d/puppetlabs.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/puppetlabs.repo",
    }
}

