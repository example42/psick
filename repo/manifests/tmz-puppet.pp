class repo::tmz-puppet {
    $extrarepo = tmz-puppet # Preferred repository (used in nrpe module)
    file {
             "/etc/yum.repos.d/tmz-puppet.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/tmz-puppet.repo",
    }
}

