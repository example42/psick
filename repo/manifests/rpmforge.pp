class repo::rpmforge {
    $extrarepo = rpmforge # Preferred repository (used in nrpe module)
    file {
             "etc/yum.repos.d/rpmforge.repo":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/repo/rpmforge.repo",
    }
}


